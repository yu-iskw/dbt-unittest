{% macro assert_true(condition) %}
  {% if not dbt_unittest.is_true(condition) %}
    {% do exceptions.raise_compiler_error("FAILED: Condition is not true.") %}
  {% endif %}
{% endmacro %}
