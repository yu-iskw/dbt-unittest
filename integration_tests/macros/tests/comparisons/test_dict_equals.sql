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

  {# Test None equality #}
  {% set result7 = dbt_unittest.dict_equals(none, none) %}
  {% if not result7 %}
    {{ exceptions.raise_compiler_error("Failed: None should be equal to None") }}
  {% endif %}

  {# Test nested dictionary equality #}
  {% set nested_dict1 = {'a': 1, 'b': {'c': 2, 'd': 3}} %}
  {% set nested_dict2 = {'a': 1, 'b': {'c': 2, 'd': 3}} %}
  {% set result8 = dbt_unittest.dict_equals(nested_dict1, nested_dict2) %}
  {% if not result8 %}
    {{ exceptions.raise_compiler_error("Failed: Identical nested dictionaries should be equal") }}
  {% endif %}

  {# Test nested dictionary inequality #}
  {% set nested_dict3 = {'a': 1, 'b': {'c': 2, 'd': 4}} %}
  {% set result9 = dbt_unittest.dict_equals(nested_dict1, nested_dict3) %}
  {% if result9 %}
    {{ exceptions.raise_compiler_error("Failed: Nested dictionaries with different values should not be equal") }}
  {% endif %}

  {# Test empty dictionary equality #}
  {% set empty_dict1 = {} %}
  {% set empty_dict2 = {} %}
  {% set result10 = dbt_unittest.dict_equals(empty_dict1, empty_dict2) %}
  {% if not result10 %}
    {{ exceptions.raise_compiler_error("Failed: Empty dictionaries should be equal") }}
  {% endif %}

  {# Test dictionary with different value types #}
  {% set dict_mixed1 = {'a': 1, 'b': 'string', 'c': true} %}
  {% set dict_mixed2 = {'a': 1, 'b': 'string', 'c': true} %}
  {% set result11 = dbt_unittest.dict_equals(dict_mixed1, dict_mixed2) %}
  {% if not result11 %}
    {{ exceptions.raise_compiler_error("Failed: Dictionaries with mixed value types should be equal") }}
  {% endif %}

  {# Test dictionary with different value types - inequality #}
  {% set dict_mixed3 = {'a': 1, 'b': 'string', 'c': false} %}
  {% set result12 = dbt_unittest.dict_equals(dict_mixed1, dict_mixed3) %}
  {% if result12 %}
    {{ exceptions.raise_compiler_error("Failed: Dictionaries with different boolean values should not be equal") }}
  {% endif %}
{% endmacro %}
