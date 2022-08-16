{% macro assert_is_not_none(value) %}
  {% if value is not none %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is none.") %}
  {% endif %}
{% endmacro %}
