{% macro contains(value, expected) %}
  {% set is_in = false %}

  {# Handle different types of collections #}
  {% if expected is mapping %}
    {% set is_in = value in expected.keys() %}
  {% elif expected is iterable and expected is not string %}
    {% set is_in = value in expected %}
  {% elif expected is string %}
    {% set is_in = value in expected %}
  {% else %}
    {% set is_in = value == expected %}
  {% endif %}

  {{ return(is_in) }}
{% endmacro %}
