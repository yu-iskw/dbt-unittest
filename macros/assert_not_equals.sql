{% macro assert_not_equals(actual, unexpected, message=none) %}
  {% if not dbt_unittest.not_equals(actual, unexpected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: " ~ actual ~ " should not equal " ~ unexpected ~ ".") %}
  {% endif %}
{% endmacro %}
