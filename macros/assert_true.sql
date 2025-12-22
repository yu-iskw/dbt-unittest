{% macro assert_true(condition) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.is_true(condition) %}
      {% do exceptions.raise_compiler_error("FAILED: Condition is not true.") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.is_true(condition) %}
      {{ dbt_unittest.propagate_fail("FAILED: Condition is not true.") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
