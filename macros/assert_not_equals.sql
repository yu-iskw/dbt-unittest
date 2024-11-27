{% macro assert_not_equals(actual, unexpected) %}
  {% if not dbt_unittest.not_equals(actual, unexpected) %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ actual ~ " should not equal " ~ unexpected ~ ".") %}
  {% endif %}
{% endmacro %}
