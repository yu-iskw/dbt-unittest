{% macro test_not_in() %}
  {# Test successful not in condition with list #}
  {% set result1 = dbt_unittest.not_in(6, [1, 2, 3, 4, 5]) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: 6 should not be in [1, 2, 3, 4, 5]") }}
  {% endif %}

  {# Test failed not in condition with list #}
  {% set result2 = dbt_unittest.not_in(5, [1, 2, 3, 4, 5]) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: 5 should be in [1, 2, 3, 4, 5]") }}
  {% endif %}

  {# Test successful not in condition with string #}
  {% set result3 = dbt_unittest.not_in('f', 'abcde') %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 'f' should not be in 'abcde'") }}
  {% endif %}

  {# Test failed not in condition with string #}
  {% set result4 = dbt_unittest.not_in('a', 'abcde') %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 'a' should be in 'abcde'") }}
  {% endif %}
{% endmacro %}
