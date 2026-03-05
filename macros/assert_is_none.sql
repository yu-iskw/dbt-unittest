{% macro assert_is_none(value) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.is_none(value) %}
      {% do exceptions.raise_compiler_error("FAILED: Value is not None.") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.is_none(value) %}
      {{ dbt_unittest.propagate_fail("FAILED: Value is not None.") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
