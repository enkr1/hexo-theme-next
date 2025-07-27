{#
  Journal Post Detail Template
  ===========================
  This template displays individual journal entries with a custom layout.

  Usage:
  - Add layout: journal-post to your journal post front-matter:
    ---
    title: My Journal Entry
    categories:
      - Journals
    layout: journal-post
    ---
#}

{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ page.title }} | {{ title }}{% endblock %}

{% block class %}journal-post posts-expand{% endblock %}

{% block content %}
  {{ partial('_macro/post.swig', {post: page}) }}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}
