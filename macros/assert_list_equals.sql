{% macro assert_list_equals(value, expected) %}
  {% if value is not iterable %}
    {% do exceptions.raise_compiler_error("FAILED: 1st argument " ~ value ~ " is not iterable.") %}
  {% endif %}
  {% if expected is not iterable %}
    {% do exceptions.raise_compiler_error("FAILED: 2nd argument " ~ expected ~ " is not iterable.") %}
  {% endif %}

  {% set length_of_1st_arg = value | length %}
  {% set length_of_2nd_arg = expected | length %}

  {% if length_of_1st_arg != length_of_2nd_arg %}
      {% do exceptions.raise_compiler_error("FAILED: lengths of the two are not equal.") %}
  {% endif %}

  {% for i in range(length_of_1st_arg) %}
    {% if value[i] != expected[i] %}
      {% do exceptions.raise_compiler_error("FAILED: values at the index {{ i }} is not equal.") %}
    {% endif %}
  {% endfor %}

  {% do log("SUCCESS") %}
{% endmacro %}
