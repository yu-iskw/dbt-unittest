{% macro assert_not_in(value, unexpected) %}
  {% if var('raise_on_error', true) %}
    {% if not dbt_unittest.not_in(value, unexpected) %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is in " ~ unexpected ~ ".") %}
    {% endif %}
  {% else %}
    {% if not dbt_unittest.not_in(value, unexpected) %}
      {{ dbt_unittest.propagate_fail("FAILED: " ~ value ~ " is in " ~ unexpected ~ ".") }}
    {% else %}
      {{ dbt_unittest.propagate_pass() }}
    {% endif %}
  {% endif %}
{% endmacro %}
