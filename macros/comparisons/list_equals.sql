{% macro list_equals(actual, expected) %}
  {# Handle None cases #}
  {% if actual is none and expected is none %}
    {{ return(true) }}
  {% endif %}

  {# Check for None values #}
  {% if actual is none or expected is none %}
    {{ return(false) }}
  {% endif %}

  {# Ensure both arguments are iterables and not strings #}
  {% if actual is not iterable or expected is not iterable %}
    {{ return(false) }}
  {% endif %}
  {% if actual is string or expected is string %}
    {{ return(false) }}
  {% endif %}

  {# Check length #}
  {% if actual | length != expected | length %}
    {{ return(false) }}
  {% endif %}

  {# Compare each element, recursively handling lists and dicts #}
  {% for i in range(actual | length) %}
    {% set a = actual[i] %}
    {% set b = expected[i] %}
    {% if a is mapping and b is mapping %}
      {% if not dbt_unittest.dict_equals(a, b) %}
        {{ return(false) }}
      {% endif %}
    {% elif a is iterable and a is not string and b is iterable and b is not string %}
      {% if not dbt_unittest.list_equals(a, b) %}
        {{ return(false) }}
      {% endif %}
    {% elif a != b %}
      {{ return(false) }}
    {% endif %}
  {% endfor %}

  {{ return(true) }}
{% endmacro %}
