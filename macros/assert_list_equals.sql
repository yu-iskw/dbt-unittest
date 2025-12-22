{% macro assert_list_equals(actual, expected) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.list_equals(actual, expected) %}
      {% do exceptions.raise_compiler_error("FAILED: Lists are not equal.") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.list_equals(actual, expected) %}
      {{ dbt_unittest.propagate_fail("FAILED: Lists are not equal.") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
