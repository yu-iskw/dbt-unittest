{% macro assert_list_equals(actual, expected) %}
  {% if not dbt_unittest.list_equals(actual, expected) %}
    {% do exceptions.raise_compiler_error("FAILED: Lists are not equal.") %}
  {% endif %}
{% endmacro %}
