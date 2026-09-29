---
layout: default
title: Home
---

# Personal Notes

A collection of things I'm learning, understanding, and trying to remember.

{% assign domains = site.notes | group_by: "domain" %}

{% for domain in domains %}

<h2>{{ domain.name }}</h2>

<ul class="topic-list">

{% assign topics = domain.items | sort: "title" %}

{% for note in topics %}

<li>
  <a href="{{ note.url | relative_url }}">
    {{ note.title }}
  </a>

  {% if note.description %}
  <div class="description">
    {{ note.description }}
  </div>
  {% endif %}
</li>

{% endfor %}

</ul>

{% endfor %}
