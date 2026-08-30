{% macro assert_true(condition, message=none) %}
  {% if not dbt_unittest.is_true(condition) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Condition is not true.") %}
  {% endif %}
{% endmacro %}
