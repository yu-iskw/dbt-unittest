{% macro assert_not_in(value, unexpected, message=none) %}
  {% if not dbt_unittest.not_in(value, unexpected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: " ~ value ~ " is in " ~ unexpected ~ ".") %}
  {% endif %}
{% endmacro %}
