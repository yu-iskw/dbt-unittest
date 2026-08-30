{% macro assert_equals(actual, expected, message=none) %}
  {% if not dbt_unittest.equals(actual, expected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: " ~ actual ~ " does not equal " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
