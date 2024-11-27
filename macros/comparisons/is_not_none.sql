{% macro is_not_none(value) %}
  {{ return(value is not none) }}
{% endmacro %}
