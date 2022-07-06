{% macro assert_equals(value, expected) %}
  {% if value == expected %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not equal to " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
