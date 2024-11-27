{% macro assert_dict_equals(actual, expected) %}
  {% if not dbt_unittest.dict_equals(actual, expected) %}
    {% do exceptions.raise_compiler_error("FAILED: Dictionaries are not equal.") %}
  {% endif %}
{% endmacro %}
