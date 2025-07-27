{#
  Journal Layout Template
  ======================
  This template displays posts from the "Journals" category in a blog-style format.

  Requirements:
  - Posts must have the exact category name "Journals" to appear here
  - Example front-matter for posts to show in this layout:
    ---
    title: My Journal Entry
    categories:
      - Journals
    ---

  Usage:
  - Create a page with layout: journal in front-matter
  - Example: /journals/index.md with content:
    ---
    title: My Journals
    layout: journal
    ---

  Features:
  - Displays full post previews similar to the home page
  - Sorts posts by date (newest first)
  - Includes pagination support
  - Shows sidebar
#}

{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ __('Journals') }} | {{ title }}{% endblock %}

{% block class %}journal posts-expand{% endblock %}

{% block content %}

  {# Filter for journal posts #}
  {% set journal_posts = [] %}
  {% for category in site.categories.toArray() %}
    {% if category.name === 'Journals' %}
      {% set journal_posts = category.posts.sort('-date') %}
    {% endif %}
  {% endfor %}

  {%- for post in journal_posts.toArray() %}

    {{ partial('_macro/post.swig', { post: post, is_index: true, is_customised_journal_list: true}) }}
  {%- endfor %}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
