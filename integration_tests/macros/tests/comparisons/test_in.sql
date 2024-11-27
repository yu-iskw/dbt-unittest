{% macro test_in() %}
  {# Test successful in condition with list #}
  {% set result1 = dbt_unittest.in(5, [1, 2, 3, 4, 5]) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should be in [1, 2, 3, 4, 5]") }}
  {% endif %}

  {# Test failed in condition with list #}
  {% set result2 = dbt_unittest.in(6, [1, 2, 3, 4, 5]) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: 6 should not be in [1, 2, 3, 4, 5]") }}
  {% endif %}

  {# Test successful in condition with string #}
  {% set result3 = dbt_unittest.in('a', 'abcde') %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 'a' should be in 'abcde'") }}
  {% endif %}

  {# Test failed in condition with string #}
  {% set result4 = dbt_unittest.in('f', 'abcde') %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 'f' should not be in 'abcde'") }}
  {% endif %}
{% endmacro %}
