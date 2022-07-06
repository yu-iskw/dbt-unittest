{% macro test_assert_true() %}
  {{ dbt_unittest.assert_true(true) }}
  {{ dbt_unittest.assert_true(1 == 1) }}
  {{ dbt_unittest.assert_true("1" == "1") }}

  {% set x = none %}
  {{ dbt_unittest.assert_true(x is none) }}
{% endmacro %}
