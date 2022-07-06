{% macro assert_dict_equals(value, expected) %}
  {% if value is not mapping %}
    {% do exceptions.raise_compiler_error("FAILED: 1st argument " ~ value ~ " is not mapping.") %}
  {% endif %}
  {% if expected is not mapping %}
    {% do exceptions.raise_compiler_error("FAILED: 2nd argument " ~ value ~ " is not mapping.") %}
  {% endif %}

  {% for k, v in value.items() %}
    {% if k not in expected %}
      {% do exceptions.raise_compiler_error("FAILED: key " ~ k ~ " of 1st argument is not in " ~ expected ~ ".") %}
    {% endif %}

    {% if v is none and expected[k] is not none %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}

    {% if v != expected[k] %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}
  {% endfor %}

  {% for k, v in expected.items() %}
    {% if k not in values %}
      {% do exceptions.raise_compiler_error("FAILED: key " ~ k ~ " of 1st argument is not in " ~ expected ~ ".") %}
    {% endif %}

    {% if v is none and values[k] is not none %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}

    {% if v != values[k] %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}
  {% endfor %}

  {% do log("SUCCESS") %}
{% endmacro %}
