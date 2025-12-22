{% macro assert_equals(actual, expected) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.equals(actual, expected) %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ actual ~ " does not equal " ~ expected ~ ".") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.equals(actual, expected) %}
      {{ dbt_unittest.propagate_fail("FAILED: " ~ actual ~ " does not equal " ~ expected ~ ".") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
