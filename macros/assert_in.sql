{% macro assert_in(value, expected, message=none) %}
  {% if not dbt_unittest.contains(value, expected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: " ~ value ~ " is not in " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
