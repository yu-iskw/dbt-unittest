{% macro test_assert_list_equals() %}
  {{ dbt_unittest.assert_equals([], []) }}
  {{ dbt_unittest.assert_equals([1, 2], [1, 2]) }}
  {{ dbt_unittest.assert_equals(["1", "2"], ["1", "2"]) }}
{% endmacro %}
