{% macro assert_false(condition) %}
  {% if not dbt_unittest.is_false(condition) %}
    {% do exceptions.raise_compiler_error("FAILED: Condition is not false.") %}
  {% endif %}
{% endmacro %}
