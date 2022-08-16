{% macro assert_in(value, expected) %}
  {% if value in expected %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not in " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
