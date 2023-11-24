{% macro assert_equals(value, expected, stdout=false) %}
  {% if value == expected %}
    {% do log("SUCCESS", info=stdout) %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: " ~ value ~ " is not equal to " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
