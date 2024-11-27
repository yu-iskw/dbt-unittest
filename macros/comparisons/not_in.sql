{% macro not_in(value, expected) %}
  {% set is_not_in = true %}

  {# Handle different types of collections #}
  {% if expected is mapping %}
    {% set is_not_in = value not in expected.keys() %}
  {% elif expected is iterable and expected is not string %}
    {% set is_not_in = value not in expected %}
  {% elif expected is string %}
    {% set is_not_in = value not in expected %}
  {% else %}
    {% set is_not_in = value != expected %}
  {% endif %}

  {{ return(is_not_in) }}
{% endmacro %}
