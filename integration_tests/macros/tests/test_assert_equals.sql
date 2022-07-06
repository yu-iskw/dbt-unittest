{% macro test_assert_equals() %}
  {{ dbt_unittest.assert_equals(1, 1) }}
  {{ dbt_unittest.assert_equals("1", "1") }}
  {{ dbt_unittest.assert_equals(none, none) }}
{% endmacro %}
