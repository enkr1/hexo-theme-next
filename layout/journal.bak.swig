{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template with context %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ __('title.journal') }} | {{ title }}{% endblock %}

{% block class %}journal{% endblock %}

{% block content %}

  {######################}
  {### JOURNAL BLOCK ###}
  {######################}

  <div class="post-block">
    <div class="posts-collapse">
      <div class="collection-title">
        <h2 class="collection-header">
          {{- __('title.journal') }}
        </h2>
      </div>

      {% set journal_posts = get_journal_posts() %}
      <p>Number of journal posts: {{ journal_posts.length }}</p>

      <ul>
        {% for post in journal_posts %}
          <li>{{ post.title }}</li>
        {% endfor %}
      </ul>

      {% if journal_posts.length %}
        {{ post_template.render(journal_posts) }}
      {% else %}
        <p>No journal entries found.</p>
      {% endif %}
    </div>
  </div>
  {########################}
  {### END JOURNAL BLOCK ###}
  {########################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
