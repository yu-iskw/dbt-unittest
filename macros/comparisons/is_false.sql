{% macro is_false(condition) %}
  {{ return(condition == false or condition is false) }}
{% endmacro %}
