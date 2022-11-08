{% macro assert_not_in(value, expected) %}
  {% if value not in expected %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is in " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
