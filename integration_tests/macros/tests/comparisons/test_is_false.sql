{% macro test_is_false() %}
  {# Test successful false condition #}
  {% set result1 = dbt_unittest.is_false(false) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: false should be false") }}
  {% endif %}

  {# Test failed false condition #}
  {% set result2 = dbt_unittest.is_false(true) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: true should not be false") }}
  {% endif %}

  {# Test false with boolean expression #}
  {% set x = 5 %}
  {% set result3 = dbt_unittest.is_false(x != 5) %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: 5 != 5 should be false") }}
  {% endif %}

  {# Test true with boolean expression #}
  {% set result4 = dbt_unittest.is_false(x == 5) %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: 5 == 5 should not be false") }}
  {% endif %}
{% endmacro %}
