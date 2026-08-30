{% macro assert_false(condition, message=none) %}
  {% if not dbt_unittest.is_false(condition) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Condition is not false.") %}
  {% endif %}
{% endmacro %}
