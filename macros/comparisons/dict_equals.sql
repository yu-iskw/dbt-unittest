{% macro dict_equals(actual, expected) %}
  {# Handle None cases #}
  {% if actual is none and expected is none %}
    {{ return(true) }}
  {% endif %}

  {# Check for None values #}
  {% if actual is none or expected is none %}
    {{ return(false) }}
  {% endif %}

  {# Check for mapping types #}
  {% if actual is not mapping or expected is not mapping %}
    {{ return(false) }}
  {% endif %}

  {# Check key lengths #}
  {% set actual_keys = actual.keys() | list | sort %}
  {% set expected_keys = expected.keys() | list | sort %}
  {% if actual_keys | length != expected_keys | length %}
    {{ return(false) }}
  {% endif %}

  {# Check keys exist and match #}
  {% for key in actual_keys %}
    {% if key not in expected_keys %}
      {{ return(false) }}
    {% endif %}
  {% endfor %}

  {# Check values, recursively for nested dicts #}
  {% for key in actual_keys %}
    {% set a = actual[key] %}
    {% set b = expected[key] %}

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

  {# If we've made it this far, dictionaries are equal #}
  {{ return(true) }}
{% endmacro %}
