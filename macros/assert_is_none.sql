{% macro assert_is_none(value, message=none) %}
  {% if not dbt_unittest.is_none(value) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Value is not None.") %}
  {% endif %}
{% endmacro %}
