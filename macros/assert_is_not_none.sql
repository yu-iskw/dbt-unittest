{% macro assert_is_not_none(value, message=none) %}
  {% if not dbt_unittest.is_not_none(value) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Value is None.") %}
  {% endif %}
{% endmacro %}
