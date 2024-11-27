{% macro equals(actual, expected) %}
  {{ return(actual == expected) }}
{% endmacro %}
