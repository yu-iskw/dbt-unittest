{% macro assert_in(value, expected) %}
  {% if not dbt_unittest.in(value, expected) %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not in " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
