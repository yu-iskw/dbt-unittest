{% macro test_is_true() %}
  {# Test successful true condition #}
  {% set result1 = dbt_unittest.is_true(true) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: true should be true") }}
  {% endif %}

  {# Test failed true condition #}
  {% set result2 = dbt_unittest.is_true(false) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: false should not be true") }}
  {% endif %}

  {# Test true with boolean expression #}
  {% set x = 5 %}
  {% set result3 = dbt_unittest.is_true(x == 5) %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 5 == 5 should be true") }}
  {% endif %}

  {# Test false with boolean expression #}
  {% set result4 = dbt_unittest.is_true(x != 5) %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 5 != 5 should not be true") }}
  {% endif %}
{% endmacro %}
