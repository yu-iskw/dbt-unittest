{% macro assert_not_in(value, unexpected) %}
  {% if not dbt_unittest.not_in(value, unexpected) %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is in " ~ unexpected ~ ".") %}
  {% endif %}
{% endmacro %}
