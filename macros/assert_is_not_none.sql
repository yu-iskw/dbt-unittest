{% macro assert_is_not_none(value, stdout=false) %}
  {% if value is not none %}
    {% do log("SUCCESS", info=stdout) %}
  {% else %}
    {% do exceptions.raise_compiler_error("FAILED: value " ~ value ~ " is none.") %}
  {% endif %}
{% endmacro %}
