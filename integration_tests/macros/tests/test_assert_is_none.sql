{% macro test_assert_is_none() %}
  {{ dbt_unittest.assert_is_none(none) }}
  {% set x = none %}
  {{ dbt_unittest.assert_is_none(x) }}
{% endmacro %}
