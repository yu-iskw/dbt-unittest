{% macro assert_is_none(value) %}
  {% if not dbt_unittest.is_none(value) %}
    {% do exceptions.raise_compiler_error("FAILED: Value is not None.") %}
  {% endif %}
{% endmacro %}
