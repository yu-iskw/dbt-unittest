{% macro test_assert_not_equals() %}
  {{ dbt_unittest.assert_not_equals(1, 2) }}
  {{ dbt_unittest.assert_not_equals("1", "2") }}
  {{ dbt_unittest.assert_not_equals(none, 1) }}
{% endmacro %}
