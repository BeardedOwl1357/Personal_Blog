---
layout: default
title: Home
---

# Personal Blog

A collection of things I'm learning, understanding, and trying to remember.

<div class="card-grid">
{% assign domains = site.articles | group_by: "domain" %}
{% for domain in domains %}
{% assign domain_slug = domain.name | downcase | replace: " ", "-" %}

<div class="card">
  <a class="card-link" href="{{ '/' | append: domain_slug | append: '/' | relative_url }}">
    <div class="card-title">{{ domain.name }}</div>
    <div class="card-description">
      {{ domain.size }} article{% unless domain.size == 1 %}s{% endunless %}
    </div>
    <div class="card-action">Explore →</div>
  </a>
</div>

{% endfor %}
</div>