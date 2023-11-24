{% macro assert_false(value, stdout=false) %}
  {% if value is not boolean %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not boolean.") %}
  {% endif %}

  {% if value is false %}
    {% do log("SUCCESS", info=stdout) %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not false.") %}
  {% endif %}
{% endmacro %}
