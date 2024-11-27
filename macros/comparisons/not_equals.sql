{% macro not_equals(actual, unexpected) %}
  {{ return(actual != unexpected) }}
{% endmacro %}
