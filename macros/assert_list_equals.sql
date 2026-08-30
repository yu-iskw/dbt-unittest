{% macro assert_list_equals(actual, expected, message=none) %}
  {% if not dbt_unittest.list_equals(actual, expected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Lists are not equal.") %}
  {% endif %}
{% endmacro %}
