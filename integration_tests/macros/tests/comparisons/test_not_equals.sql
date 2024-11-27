{% macro test_not_equals() %}
  {# Test successful not equals #}
  {% set result1 = dbt_unittest.not_equals(5, 6) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should not equal 6") }}
  {% endif %}

  {# Test failed not equals #}
  {% set result2 = dbt_unittest.not_equals(5, 5) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should equal 5") }}
  {% endif %}

  {# Test string not equals #}
  {% set result3 = dbt_unittest.not_equals('hello', 'world') %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 'hello' should not equal 'world'") }}
  {% endif %}

  {# Test string equals #}
  {% set result4 = dbt_unittest.not_equals('hello', 'hello') %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 'hello' should equal 'hello'") }}
  {% endif %}
{% endmacro %}
