{% macro assert_is_not_none(value) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.is_not_none(value) %}
      {% do exceptions.raise_compiler_error("FAILED: Value is None.") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.is_not_none(value) %}
      {{ dbt_unittest.propagate_fail("FAILED: Value is None.") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
