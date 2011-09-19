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
axes -- typically in our case "foo by bar by year" for a time series. However,
we use Solr 1.4.1 and are unlikely to migrate to Solr 4.0 in the meantime,
while at the same time really wanting pivot facets. After some research,
experimentation and a good amount of hackery, I was able to come up with a
"faux" pivot facet scheme that approximates true facet pivoting with two
Solr queries in Solr 1.4.1.





[solr]: http://lucene.apache.org/solr/
[solr_facet]: http://wiki.apache.org/solr/SolrFacetingOverview
[pivot_facet]: http://wiki.apache.org/solr/SimpleFacetParameters#Pivot_.28ie_Decision_Tree.29_Faceting
[solr4]: http://wiki.apache.org/solr/Solr4.0





<!-- more start -->

## TODO -- Other Cites

[jira792]: https://issues.apache.org/jira/browse/SOLR-792#referrer=solr.pl
[solrpl_pivot]: http://solr.pl/en/2010/10/25/hierarchical-faceting-pivot-facets-in-trunk/




## TODO

* Description

* Example Schema

  * company
  * product
  * year
  * category

* Works for:

  * Facet queries
  * Distributed Solr


<!-- more end -->
