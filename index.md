---
layout: default
title: Home
---

# Personal Blog

A collection of things I'm learning, understanding, and trying to remember.

<h2>Categories</h2>

<ul class="topic-list">

{% assign domains = site.articles | group_by: "domain" %}

{% for domain in domains %}

{% assign domain_slug = domain.name | downcase | replace: " ", "-" %}

<li>
  <a href="{{ '/' | append: domain_slug | append: '/' | relative_url }}">
    {{ domain.name }}
  </a>

  <div class="description">
    {{ domain.size }} articles
  </div>
</li>

{% endfor %}

</ul>