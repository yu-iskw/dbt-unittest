{% macro assert_false(condition) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.is_false(condition) %}
      {% do exceptions.raise_compiler_error("FAILED: Condition is not false.") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.is_false(condition) %}
      {{ dbt_unittest.propagate_fail("FAILED: Condition is not false.") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
