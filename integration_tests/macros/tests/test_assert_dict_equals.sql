{% macro test_assert_dict_equals() %}
  {% set x = {
     "k1": 1,
     "k2": "2",
     "k3": none,
     "k4": True,
     "k5": False,
    } %}
  {% set y = {
     "k1": 1,
     "k2": "2",
     "k3": none,
     "k4": True,
     "k5": False,
    } %}
  {{ dbt_unittest.assert_dict_equals(x, y) }}
{% endmacro %}
