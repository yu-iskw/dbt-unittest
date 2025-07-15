{% macro assert_not_equals(actual, unexpected) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.not_equals(actual, unexpected) %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ actual ~ " should not equal " ~ unexpected ~ ".") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.not_equals(actual, unexpected) %}
      {{ dbt_unittest.propagate_fail("FAILED: " ~ actual ~ " should not equal " ~ unexpected ~ ".") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
