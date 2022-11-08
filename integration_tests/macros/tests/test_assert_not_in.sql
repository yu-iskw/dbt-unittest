{% macro test_assert_not_in() %}
  {{ dbt_unittest.assert_not_in(4, [1, 2, 3]) }}
  {{ dbt_unittest.assert_not_in("4", ["1", "2", "3"]) }}
{% endmacro %}
