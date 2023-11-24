{% macro assert_is_none(value, stdout=false) %}
  {% if value is none %}
    {% do log("SUCCESS", info=stdout) %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is not none.") %}
  {% endif %}
{% endmacro %}
