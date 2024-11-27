{% macro test_is_none() %}
  {# Test successful is_none condition #}
  {% set result1 = dbt_unittest.is_none(none) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: None should be None") }}
  {% endif %}

  {# Test failed is_none conditions #}
  {% set result2 = dbt_unittest.is_none(true) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: true should not be None") }}
  {% endif %}

  {% set result3 = dbt_unittest.is_none(1) %}
  {% if result3 %}
    {{ exceptions.raise_compiler_error("Failed: 1 should not be None") }}
  {% endif %}

  {% set result4 = dbt_unittest.is_none([1, 2, 3]) %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: list should not be None") }}
  {% endif %}

  {% set result5 = dbt_unittest.is_none({"1": "2"}) %}
  {% if result5 %}
    {{ exceptions.raise_compiler_error("Failed: dictionary should not be None") }}
  {% endif %}
{% endmacro %}
