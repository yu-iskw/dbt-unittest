{% macro test_assert_is_not_none() %}
  {{ dbt_unittest.assert_is_not_none(1) }}
  {{ dbt_unittest.assert_is_not_none("1") }}
  {{ dbt_unittest.assert_is_not_none([1]) }}
  {{ dbt_unittest.assert_is_not_none({"x": "1"}) }}
{% endmacro %}
