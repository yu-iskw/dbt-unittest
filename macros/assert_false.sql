{% macro assert_false(value) %}
  {% if value is not boolean %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not boolean.") %}
  {% endif %}

  {% if value is false %}
    {% do log("SUCCESS") %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not false.") %}
  {% endif %}
{% endmacro %}
