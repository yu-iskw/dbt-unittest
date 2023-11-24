{% macro assert_in(value, expected, stdout=false) %}
  {% if value in expected %}
    {% do log("SUCCESS", info=stdout) %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not in " ~ expected ~ ".") %}
  {% endif %}
{% endmacro %}
