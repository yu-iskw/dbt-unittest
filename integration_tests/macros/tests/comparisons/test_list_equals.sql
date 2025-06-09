{% macro test_list_equals() %}
  {# Identical lists #}
  {% set list1 = [1, 2, 3] %}
  {% set list2 = [1, 2, 3] %}
  {% set result1 = dbt_unittest.list_equals(list1, list2) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: identical lists should be equal") }}
  {% endif %}

  {# Different lists #}
  {% set list3 = [1, 2, 4] %}
  {% set result2 = dbt_unittest.list_equals(list1, list3) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: different lists should not be equal") }}
  {% endif %}

  {# Empty lists #}
  {% set list4 = [] %}
  {% set list5 = [] %}
  {% set result3 = dbt_unittest.list_equals(list4, list5) %}
  {% if not result3 %}
    {{ exceptions.raise_compiler_error("Failed: empty lists should be equal") }}
  {% endif %}

  {# Lists of dictionaries #}
  {% set list6 = [{'a': 1}, {'b': 2}] %}
  {% set list7 = [{'a': 1}, {'b': 2}] %}
  {% set result4 = dbt_unittest.list_equals(list6, list7) %}
  {% if not result4 %}
    {{ exceptions.raise_compiler_error("Failed: list of dicts should be equal") }}
  {% endif %}

  {% set list8 = [{'a': 1}, {'b': 3}] %}
  {% set result5 = dbt_unittest.list_equals(list6, list8) %}
  {% if result5 %}
    {{ exceptions.raise_compiler_error("Failed: list of dicts with different values should not be equal") }}
  {% endif %}

  {# Nested lists #}
  {% set list9 = [[1, 2], [3, 4]] %}
  {% set list10 = [[1, 2], [3, 4]] %}
  {% set result6 = dbt_unittest.list_equals(list9, list10) %}
  {% if not result6 %}
    {{ exceptions.raise_compiler_error("Failed: nested lists should be equal") }}
  {% endif %}
{% endmacro %}
