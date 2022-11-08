{% macro test_macros() %}
  {% do test_assert_dict_equals() %}

  {% do test_assert_equals() %}

  {% do test_assert_false() %}

  {% do test_assert_in() %}

  {% do test_assert_not_in() %}

  {% do test_assert_is_none() %}

  {% do test_assert_is_not_none() %}

  {% do test_assert_list_equals() %}

  {% do test_assert_not_equals() %}

  {% do test_assert_true() %}
{% endmacro %}
