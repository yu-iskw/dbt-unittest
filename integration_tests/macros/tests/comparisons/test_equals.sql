{% macro test_equals() %}
  {# Test successful equality #}
  {% set result1 = dbt_unittest.equals(5, 5) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should equal 5") }}
  {% endif %}

  {# Test failed equality #}
  {% set result2 = dbt_unittest.equals(5, 6) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should not equal 6") }}
  {% endif %}

  {# Test string equality #}
  {% set result3 = dbt_unittest.equals('hello', 'hello') %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 'hello' should equal 'hello'") }}
  {% endif %}

  {# Test string inequality #}
  {% set result4 = dbt_unittest.equals('hello', 'world') %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 'hello' should not equal 'world'") }}
  {% endif %}
{% endmacro %}
