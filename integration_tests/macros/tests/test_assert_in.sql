{% macro test_assert_in() %}
  {{ dbt_unittest.assert_in(1, [1, 2, 3]) }}
  {{ dbt_unittest.assert_in("1", ["1", "2", "3"]) }}
  {{ dbt_unittest.assert_in(none, [none]) }}
{% endmacro %}
