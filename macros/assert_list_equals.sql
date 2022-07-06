{% macro assert_list_equals(value, expected) %}
  {% if value is not iterable %}
    {% do exceptions.raise_compiler_error("FAILED: 1st argument " ~ value ~ " is not iterable.") %}
  {% endif %}
  {% if expected is not iterable %}
    {% do exceptions.raise_compiler_error("FAILED: 2nd argument " ~ value ~ " is not iterable.") %}
  {% endif %}

  {% for x in value %}
    {% if x not in expected %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ x ~ " of 1st argument is not in " ~ expected ~ ".") %}
    {% endif %}
  {% endfor %}

  {% for x in expected %}
    {% if x not in value %}
      {% do exceptions.raise_compiler_error("FAILED: " ~ x ~ " of 2nd argument is not in " ~ value ~ ".") %}
    {% endif %}
  {% endfor %}

  {% do log("SUCCESS") %}
{% endmacro %}
