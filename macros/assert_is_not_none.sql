{% macro assert_is_not_none(value) %}
  {% if not dbt_unittest.is_not_none(value) %}
    {% do exceptions.raise_compiler_error("FAILED: Value is None.") %}
  {% endif %}
{% endmacro %}
