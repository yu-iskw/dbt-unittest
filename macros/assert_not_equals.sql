{% macro assert_not_equals(value, expected, stdout=false) %}
  {% if value != expected %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is equal to " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
