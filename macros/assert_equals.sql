{% macro assert_equals(actual, expected) %}
  {% if not dbt_unittest.equals(actual, expected) %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ actual ~ " does not equal " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
