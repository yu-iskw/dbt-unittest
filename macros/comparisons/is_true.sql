{% macro is_true(condition) %}
  {{ return(condition == true or condition is true) }}
{% endmacro %}
