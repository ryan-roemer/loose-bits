---
layout: post
title: Pivot Faceting (Decision Trees) in Solr 1.4.
description: TODO
date: 2011-09-19 16:00:00 UTC
tags: ['search', 'solr', 'hacks']
---

## Solr Pivot Facets

Solr [faceting][solr_facet] breaks down searches for terms, phrases, and fields in the [Solr][solr] into aggregated counts by matched fields or queries.
Facets are a great way to "preview" further searches, as well as a powerful
aggregation tool in their own right.

Before [Solr 4.0][solr4], facets were only available at one level, meaning
something like "counts for field 'foo'" for a given query.  Solr 4.0
introduced [pivot facets][pivot_facet] (also called decision trees) which
enable facet queries to return "counts for field 'foo' for each different field
'bar'" -- a multi-level facet across separate Solr fields.

Decision trees come up a lot, and at work, we need results along multiple
axes -- typically in our case "field/query by year" for a time series. However,
we use Solr 1.4.1 and are unlikely to migrate to Solr 4.0 in the meantime,
while at the same time really wanting pivot facets. After some research,
experimentation and a good amount of hackery, I was able to come up with a
"faux" pivot facet scheme that approximates true facet pivoting in Solr 1.4.1.

## Pivot Faceting in Solr 4.0

Pivot facets were added to Solr in [SOLR-792][jira792]. A good introductory
[article][solrpl_pivot] is available on the TODO blog. To see the basic
operation in action, let's just use the "example" setup that comes with
the Solr 4.0 distribution (located at "solr_path/solr/example").

Let's start the Solr process:

{% highlight bash %}
# Start Solr as non-daemon
$ cd solr_path/solr/example
$ java -jar start.jar
{% endhighlight %}

Next, we want to upload a series of documents. We'll use the provided example
script "post.sh" and create a simple CSV file for the script. The format
is: first line is field names, other lines are data. I've taken the sample
"exampledocs/books.csv" file and changed some schema names. Write this out
to a custom file.

{% highlight bash %}
# Create CSV file.
$ vim sample_books.csv
id,cat_s,name_s,price_f,inStock_b,author_s,series_s,sequence_i,genre_s
0553573403,book,A Game of Thrones,7.99,true,George R.R. Martin,A Song of Ice and Fire,1,fantasy
0553579908,book,A Clash of Kings,7.99,true,George R.R. Martin,A Song of Ice and Fire,2,fantasy
055357342X,book,A Storm of Swords,7.99,true,George R.R. Martin,A Song of Ice and Fire,3,fantasy
0553293354,book,Foundation,7.99,true,Isaac Asimov,Foundation Novels,1,scifi
0812521390,book,The Black Company,6.99,false,Glen Cook,The Chronicles of The Black Company,1,fantasy
0812550706,book,Enders Game,6.99,true,Orson Scott Card,Ender,1,scifi
0441385532,book,Jhereg,7.95,false,Steven Brust,Vlad Taltos,1,fantasy
0380014300,book,Nine Princes In Amber,6.99,true,Roger Zelazny,the Chronicles of Amber,1,fantasy
0805080481,book,The Book of Three,5.99,true,Lloyd Alexander,The Chronicles of Prydain,1,fantasy
080508049X,book,The Black Cauldron,5.99,true,Lloyd Alexander,The Chronicles of Prydain,2,fantasy

# Upload to Solr.
$ curl http://localhost:8983/solr/update/csv \
  --data-binary @sample_books.csv \
  -H 'Content-type:text/plain; charset=utf-8'

# Commit the upload.
$ curl http://localhost:8983/solr/update \
   --data-binary '<commit/>' \
   -H 'Content-type:application/xml'
{% endhighlight %}

Note that we use ``_s`` fields for simplicity, forcing string fields for
what would ordinarily be text fields -- Solr facets only return results on
*indexed*, not *stored* terms, and string fields are identical for both.
In a real deployment, you would use ``copyField`` directives to copy ``text``
fields to ``string`` fields for faceting.

You should now be able to query the 10 sample documents at:
``http://localhost:8983/solr/admin/form.jsp``.

Now that we have some documents to work with, let's do a simple pivot query
on genre counts grouped by price:

{% highlight bash %}
# Pivot query:
$ http://localhost:8983/solr/select?
  indent=on
  &wt=json
  &q=*%3A*
  &rows=0
  &facet=true
  &facet.sort=index
  &facet.pivot=price_f,genre_s
{% endhighlight %}

(Note that I've added line breaks to show the parameters more clearly -- you
may have to remove these for the actual ``curl`` command).

This gives us decision tree results for the ``facet_pivot`` field:

{% highlight javascript %}
{
  /* ... */,
  "facet_counts":{
    /* ... */,
    "facet_pivot":{
      "price_f,genre_s":[{
          "field":"price_f",
          "value":5.99,
          "count":2,
          "pivot":[{
              "field":"genre_s",
              "value":"fantasy",
              "count":2}]},
        {
          "field":"price_f",
          "value":6.99,
          "count":3,
          "pivot":[{
              "field":"genre_s",
              "value":"fantasy",
              "count":2},
            {
              "field":"genre_s",
              "value":"scifi",
              "count":1}]},
        {
          "field":"price_f",
          "value":7.95,
          "count":1,
          "pivot":[{
              "field":"genre_s",
              "value":"fantasy",
              "count":1}]},
        {
          "field":"price_f",
          "value":7.99,
          "count":4,
          "pivot":[{
              "field":"genre_s",
              "value":"fantasy",
              "count":3},
            {
              "field":"genre_s",
              "value":"scifi",
              "count":1}]}]}}}
{% endhighlight %}

Nice intuitive results, for a fairly straightforward facet query. However,
now to the bigger question -- can we approximate this in Solr 1.4.1, which
doesn't have the ``facet.pivot`` query option?

## Pivot Faceting in Solr 1.4.1

Solr 1.4.1 has much more limited facet support than 4.0.  The building blocks
that we will use to cobble together a "faux" pivot query are:

* **``facet.field``**: The normal facet field option.
* **``facet.query``**: The normal facet query option.
* **``fq``**: Basic field queries (for restrictions).
* **Local Params**: We use a couple of Solr [local parameters][local_params]
  * **``tag``**: Tags a ``fq`` with an arbitrary name.
  * **``key``**: Tags a facet field an arbitrary name (instead of field name).
  * **``ex``**: Excludes tagged ``fq``'s from being operative on a given facet
    field/query.

Note that either facet fields or facet queries can be used with this technique
-- I'll only show fields, but everything applies equally to queries.

At this point, you should take a Solr 1.4.1 distribution and set it up exactly
as we did above for Solr 4.0 and upload our simple 10-document CSV file to
the running server. For simplicity here (and to keep my head on straight),
I ended up running my Solr 1.4.1 server on port 8984, so that I could also
keep the Solr 4.0 server running on port 8983.

From here on, it is assumed you now have a populated Solr 1.4.1 server running
on port 8984 (switch addresses / ports as appropriate for your actual setup).

### Excluding Restrictions from Facets

The starting point for our pivot facets is excluding certain query restrictions
for facets. A [basic example][ex_facets] is provided for tagging and excluding
facets on the Solr wiki.



[solr]: http://lucene.apache.org/solr/
[solr_facet]: http://wiki.apache.org/solr/SolrFacetingOverview
[pivot_facet]: http://wiki.apache.org/solr/SimpleFacetParameters#Pivot_.28ie_Decision_Tree.29_Faceting
[solr4]: http://wiki.apache.org/solr/Solr4.0
[jira792]: https://issues.apache.org/jira/browse/SOLR-792#referrer=solr.pl
[solrpl_pivot]: http://solr.pl/en/2010/10/25/hierarchical-faceting-pivot-facets-in-trunk/
[local_params]: http://wiki.apache.org/solr/LocalParams
[ex_facets]: http://wiki.apache.org/solr/SimpleFacetParameters#Multi-Select_Faceting_and_LocalParams



<!-- more start -->

## TODO -- Other Cites






## TODO

* Description

* 3+ level pivot trees.

* Example Schema

  * company
  * product
  * year
  * category

* Works for:

  * Facet queries
  * Distributed Solr


<!-- more end -->
