{% macro assert_is_none(value) %}
  {% if value is none %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not none.") %}
  {% endif %}
{% endmacro %}
