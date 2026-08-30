{% macro test_assert_custom_message() %}
  {{ dbt_unittest.assert_equals(1, 2, "Custom assertion message") }}
{% endmacro %}
