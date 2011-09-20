---
layout: post
title: Pivot Faceting (Decision Trees) in Solr 1.4.
description: Pivot faceting, a feature introduced in Solr 4.0, can be
  approximated in Solr 1.4 using a few non-standard facet field/query
  features (and a little bit of hackery).
date: 2011-09-19 16:00:00 UTC
tags: ['search', 'solr', 'facet', 'pivot', 'hacks']
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
we use Solr 1.4.1 and are unlikely to migrate to Solr 4.0 in the meantime.
Our existing approach was to simply query for the top "n" fields for a first
query, then for *each* field result, perform a second-level facet query by
year. So, for the top 20 results, we would perform 1 + 20 queries -- clearly
not optimal, when we're trying to get this done in the context of a blocking
HTTP request in our underlying web application.

Hoping to get *something* better than our 1 + *n* separate queries approach,
I began researching the somewhat more obscure facet features present in Solr
1.4.1. And after some investigation, experimentation and a good amount of
hackery, I was able to come up with a "faux" pivot facet scheme that
mostly approximates true pivot faceting using Solr 1.4.1.

We'll start by running some real pivot facets in Solr 4.0, then look at the
components and full technique for simulated pivot facets in Solr 1.4.1.

## Pivot Faceting in Solr 4.0

Pivot facets were added to Solr in [SOLR-792][jira792]. A good introductory
[article][solrpl_pivot] is available on the TODO blog. To see the basic
operation in action, let's just use the "example" setup that comes with
the Solr 4.0 distribution (located at "solr_4.0_path/solr/example").

<!-- more start -->

Let's start the Solr process:

{% highlight bash %}
# Start Solr as non-daemon.
$ cd solr_4.0_path/solr/example
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
on price by genre:

{% highlight bash %}
# Pivot query.
$ curl http://localhost:8983/solr/select --data indent=on\
\&wt=json\
\&q=*%3A*\
\&rows=0\
\&facet=true\
\&facet.mincount=1\
\&facet.sort=index\
\&facet.pivot=price_f,genre_s
{% endhighlight %}

(Note that I've added line breaks and escapes to show the parameters more
clearly).

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

### Setup

At this point, you should take a Solr 1.4.1 distribution and set it up exactly
as we did above for Solr 4.0 and upload our simple 10-document CSV file to
the running server. For simplicity here (and to keep my head on straight),
I ended up running my Solr 1.4.1 server on port 8984, so that I could also
keep the Solr 4.0 server running on port 8983. Here's what I did:

{% highlight bash %}
# Start Solr as non-daemon.
$ cd solr_1.4.1_path/solr/example
$ java -Djetty.port=8984 -jar start.jar

# (Copy sample_books.csv)
# Upload to Solr.
$ curl http://localhost:8984/solr/update/csv \
  --data-binary @sample_books.csv \
  -H 'Content-type:text/plain; charset=utf-8'

# Commit the upload.
$ curl http://localhost:8984/solr/update \
   --data-binary '<commit/>' \
   -H 'Content-type:application/xml'
{% endhighlight %}

From here on, it is assumed you now have a populated Solr 1.4.1 server running
on port 8984 (switch addresses / ports as appropriate for your actual setup).

### Excluding Restrictions from Facets

The starting point for our pivot facets is excluding certain query restrictions
for facets. A [basic example][ex_facets] is provided for tagging and excluding
facets on the Solr wiki.

Let's do a simple facet query on prices with a restriction of
``genre_s:scifi``:

{% highlight bash %}
# Restricted facet query.
$ curl http://localhost:8984/solr/select --data \
\indent=on\
\&wt=json\
\&q=*%3A*\
\&rows=0\
\&fq=genre_s:scifi\
\&facet=true\
\&facet.mincount=1\
\&facet.sort=index\
\&facet.field=price_f
{% endhighlight %}

Looking to our results in ``facet_fields``, we see that we only have 2 hits
(``numFound``), and the facet counts also add up to 2 (which represent our 2
SciFi books).

{% highlight javascript %}
{
  /* ... */,
  "response":{"numFound":2, /* ... */},
  "facet_counts":{
    /* ... */,
    "facet_fields":{
      "price_f":[
        "6.99",1,
        "7.99",1]},
    /* ... */,
}
{% endhighlight %}

For situations like a drill down, Solr developers often want to run a basic
query with full restrictions for the returned records, but get more information
for facets. In this case, Solr allows tagging of ``fq``'s, and keys / excludes
on facets to conditionally remove ``fq``'s from a *given facet only*.

So, let's tag our ``fq`` as "SCIFI_FQ" and exclude it from out facet counts
with ``ex``, and then rename the facet results to "PRICE_KEY" using the
``key`` option:

{% highlight bash %}
# Tag fq and exclude only from the field facet.
$ curl http://localhost:8984/solr/select --data \
\indent=on\
\&wt=json\
\&q=*%3A*\
\&rows=0\
\&fq={\!tag=SCIFI_FQ}genre_s:scifi\
\&facet=true\
\&facet.mincount=1\
\&facet.sort=index\
\&facet.field={\!key=PRICE_KEY\ ex=SCIFI_FQ}price_f
{% endhighlight %}

Note that I have to escape the exclamation points and other characters for a
command line example here. Now, let's look at the results:

{% highlight javascript %}
{
  /* ... */,
  "response":{"numFound":2, /* ... */},
 "facet_counts":{
    /* ... */,
    "facet_fields":{
      "PRICE_KEY":[
        "5.99",2,
        "6.99",3,
        "7.95",1,
        "7.99",4]},
    /* ... */,
}
{% endhighlight %}

We can first see that the exclusion of the tagged "SCIFI_FQ" field query did
not affect the overall ``numFound``, which is still 2.  However, for the
facet field we applied the exclusion to, we now have facet results for records
in the whole set (which is the effective query after the exclusion). Finally,
our facet field has been renamed "PRICE_KEY" instead of the field name
("price_f").

### Constructing a Pivot Query

With the basic tag/key/exclude technique in mind, let's now return to our
original goal -- create a pivot query on price by genre using Solr 1.4.1.
We will do this by performing two queries:

1. Perform a facet query for the top price results ordered by index.
2. Create ``fq`` tagged exclusions for each facet result, then create multiple
   keyed facets on genre to give us each of our decision tree "leaf" results.

The first query is a very basic facet field query:

{% highlight bash %}
# First level facet field query.
$ curl http://localhost:8984/solr/select --data indent=on\
\&wt=json\
\&q=*%3A*\
\&rows=0\
\&facet=true\
\&facet.mincount=1\
\&facet.sort=index\
\&facet.field=price_f
{% endhighlight %}

Which gives us four individual facet results: "5.99", "6.99", "7.95", "7.99".

{% highlight javascript %}
{
  /* ... */,
  "response":{"numFound":10, /* ... */},
 "facet_counts":{
    /* ... */,
    "facet_fields":{
      "price_f":[
        "5.99",2,
        "6.99",3,
        "7.95",1,
        "7.99",4]},
    /* ... */,
}
{% endhighlight %}

We take each of those results and create specific ``fq`` tagged restrictions:

{% highlight text %}
fq={!tag=FQ5.99}price_f:5.99
fq={!tag=FQ6.99}price_f:6.99
fq={!tag=FQ7.95}price_f:7.95
fq={!tag=FQ7.99}price_f:7.99
{% endhighlight %}

Each excludes one of the components we'll want facet results for our next
level field (genre) on. To then get the pivot facet result for each of our
four facets, we will exclude all the ``fq``'s above **except** the matching
one for the facet. Translating into facet parameters, this is:

{% highlight text %}
facet.field={!key=5.99_GENRE ex=FQ6.99,FQ7.95,FQ7.99}genre_s
facet.field={!key=6.99_GENRE ex=FQ5.99,FQ7.95,FQ7.99}genre_s
facet.field={!key=7.95_GENRE ex=FQ5.99,FQ6.99,FQ7.99}genre_s
facet.field={!key=7.99_GENRE ex=FQ5.99,FQ6.99,FQ7.95}genre_s
{% endhighlight %}

The key is that we can specify *multiple* exclusions using a comma. Thus,
looking to the facet key "5.99_GENRE", we exclude all the ``fq`` restrictions
*except* "FQ5.99", which means that the facet results for that facet field
key will be the facet counts for "``fq=price_f:5.99``" only. It's kind of a
twisted-double-negative logic, but it all works out.

Let's put everything into our second-level query now:

{% highlight bash %}
# Second level pivot query.
$ curl http://localhost:8984/solr/select --data \
indent=on\
\&wt=json\
\&q=*%3A*\
\&rows=0\
\&facet=true\
\&facet.mincount=1\
\&facet.sort=index\
\&fq={\!tag=FQ5.99}price_f:5.99\
\&fq={\!tag=FQ6.99}price_f:6.99\
\&fq={\!tag=FQ7.95}price_f:7.95\
\&fq={\!tag=FQ7.99}price_f:7.99\
\&facet.field={\!key=5.99_GENRE\ ex=FQ6.99\,FQ7.95\,FQ7.99}genre_s\
\&facet.field={\!key=6.99_GENRE\ ex=FQ5.99\,FQ7.95\,FQ7.99}genre_s\
\&facet.field={\!key=7.95_GENRE\ ex=FQ5.99\,FQ6.99\,FQ7.99}genre_s\
\&facet.field={\!key=7.99_GENRE\ ex=FQ5.99\,FQ6.99\,FQ7.95}genre_s
{% endhighlight %}

Which gives us the "leaves" of the decision tree with our result keys:
"5.99_GENRE", "6.99_GENRE", "7.95_GENRE", and "7.99_GENRE".

{% highlight javascript %}
{
  /* ... */,
  "response":{"numFound":10, /* ... */},
 "facet_counts":{
    /* ... */,
    "facet_fields":{
      "5.99_GENRE":[
        "fantasy",2],
      "6.99_GENRE":[
        "fantasy",2,
        "scifi",1],
      "7.95_GENRE":[
        "fantasy",1],
      "7.99_GENRE":[
        "fantasy",3,
        "scifi",1]},
    /* ... */,
}
{% endhighlight %}

Looking at our original Solr 4.0 pivot query, we can cobble together our
two Solr 1.4.1 queries to get the equivalent results. In the end, both produce
the following decision tree for price by genre:

* **5.99**: 2

  * **fantasy**: 2

* **6.99**: 3

  * **fantasy**: 2
  * **scifi**: 1

* **7.95**: 1

  * **fantasy**: 1

* **7.99**: 4

  * **fantasy**: 3
  * **scifi**: 1

Victory!

## Discussion and Practical Implications

Our "price by genre" example is a bit simplistic in that we can mostly get
the same results with two standard Solr 1.4.1 facet field queries. But, the
faux pivot facet technique really shines for a "foo by bar"-type query where
there are large numbers of first ("foo") level facet results. Say, the first
level has 10 results, this would mean 11 queries (one for the top 10 "foo"'s,
then one each for the top second-level "bar"'s for each "foo"). The faux pivot
facet technique cuts this down to 2 queries total.

Although our examples here only use facet fields, the technique works equally
well for [facet queries][facet_query]. And it works when using
[distributed search][distributed].

Additionally, the technique can be applied to further decision tree levels.
In the Solr 4.0 world, this simply means adding another field
like ``facet.pivot=price_f,genre_s,inStock_b`` to get further breakdowns for
the "in stock" boolean field. For Solr 1.4.1, we would do a third query,
with permutations of our previous tagged ``fq``'s, as well as second-level
``fq``'s. Then, we would have third-level keyed facet fields like:
"6.99_fantasy_INSTOCK", "6.99_scifi_INSTOCK", etc. At this level, it
certainly wouldn't be pretty and would result in a beastly query, but
shows that the technique only adds 1 more actual Solr query for each
additional level in the faux decision tree.

Speaking of query complexity, it is fair to point out that this type of
query hackery really should be done programmatically to ensure correctness,
and definitely not via the manual queries I provided above using curl.
It's tough keeping track of just the 4 first-level pivots in our example above,
let alone a larger first level group, or more than 2 levels deep of pivots.
Another benefit is that you can collapse your tag / key names to integer
or other simple keys, and then have your program match things up later for
the final assembled decision tree result.

As a final performance note, the faux pivot facet approach doesn't really
lighten the Solr server load, it just collapses what would otherwise be
multiple queries into one query. Thus, if reducing the number of round trips
between a web application and Solr for single search is the goal, and you
need pivot facets in a pre-4.0 Solr, this may well be the ticket.

[distributed]: http://wiki.apache.org/solr/DistributedSearch
[ex_facets]: http://wiki.apache.org/solr/SimpleFacetParameters#Multi-Select_Faceting_and_LocalParams
[facet_query]: http://wiki.apache.org/solr/SimpleFacetParameters#facet.query_:_Arbitrary_Query_Faceting
[jira792]: https://issues.apache.org/jira/browse/SOLR-792#referrer=solr.pl
[local_params]: http://wiki.apache.org/solr/LocalParams
[pivot_facet]: http://wiki.apache.org/solr/SimpleFacetParameters#Pivot_.28ie_Decision_Tree.29_Faceting
[solr4]: http://wiki.apache.org/solr/Solr4.0
[solrpl_pivot]: http://solr.pl/en/2010/10/25/hierarchical-faceting-pivot-facets-in-trunk/
[solr]: http://lucene.apache.org/solr/
[solr_facet]: http://wiki.apache.org/solr/SolrFacetingOverview

<!-- more end -->
