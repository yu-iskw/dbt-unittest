{% macro assert_dict_equals(actual, expected, message=none) %}
  {% if not dbt_unittest.dict_equals(actual, expected) %}
    {% do exceptions.raise_compiler_error(message if message is not none else "FAILED: Dictionaries are not equal.") %}
  {% endif %}
{% endmacro %}
