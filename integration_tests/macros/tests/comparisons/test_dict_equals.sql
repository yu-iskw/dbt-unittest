{% macro test_dict_equals() %}
  {# Test successful dictionary equality #}
  {% set dict1 = {'a': 1, 'b': 2, 'c': 3} %}
  {% set dict2 = {'a': 1, 'b': 2, 'c': 3} %}
  {% set result1 = dbt_unittest.dict_equals(dict1, dict2) %}
  {% if not result1 %}
    {{ exceptions.raise_compiler_error("Failed: Identical dictionaries should be equal") }}
  {% endif %}

  {# Test failed dictionary equality - different values #}
  {% set dict3 = {'a': 1, 'b': 2, 'c': 4} %}
  {% set result2 = dbt_unittest.dict_equals(dict1, dict3) %}
  {% if result2 %}
    {{ exceptions.raise_compiler_error("Failed: Dictionaries with different values should not be equal") }}
  {% endif %}

  {# Test failed dictionary equality - different keys #}
  {% set dict4 = {'a': 1, 'b': 2, 'd': 3} %}
  {% set result3 = dbt_unittest.dict_equals(dict1, dict4) %}
  {% if result3 %}
    {{ exceptions.raise_compiler_error("Failed: Dictionaries with different keys should not be equal") }}
  {% endif %}

  {# Test failed dictionary equality - different lengths #}
  {% set dict5 = {'a': 1, 'b': 2} %}
  {% set result4 = dbt_unittest.dict_equals(dict1, dict5) %}
  {% if result4 %}
    {{ exceptions.raise_compiler_error("Failed: Dictionaries with different lengths should not be equal") }}
  {% endif %}

  {# Test failed dictionary equality - non-mapping types #}
  {% set result5 = dbt_unittest.dict_equals(dict1, [1, 2, 3]) %}
  {% if result5 %}
    {{ exceptions.raise_compiler_error("Failed: Comparing dictionary with non-mapping type should fail") }}
  {% endif %}

  {# Test failed dictionary equality - None values #}
  {% set result6 = dbt_unittest.dict_equals(dict1, none) %}
  {% if result6 %}
    {{ exceptions.raise_compiler_error("Failed: Comparing dictionary with None should fail") }}
  {% endif %}
{% endmacro %}
