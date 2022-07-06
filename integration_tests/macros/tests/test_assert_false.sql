{% macro test_assert_false() %}
  {{ dbt_unittest.assert_false(false) }}
  {{ dbt_unittest.assert_false(1 != 1) }}
  {{ dbt_unittest.assert_false("1" != "1") }}

  {% set x = none %}
  {{ dbt_unittest.assert_false(x is not none) }}
{% endmacro %}
