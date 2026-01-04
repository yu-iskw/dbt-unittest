{% macro assert_in(value, expected) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.contains(value, expected) %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not in " ~ expected ~ ".") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.contains(value, expected) %}
      {{ dbt_unittest.propagate_fail("FAILED: " ~ value ~ " is not in " ~ expected ~ ".") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
