{% macro assert_dict_equals(value, expected) %}
  {% if value is not mapping %}
    {% do exceptions.raise_compiler_error("FAILED: 1st argument " ~ value ~ " is not a mapping.") %}
  {% endif %}
  {% if expected is not mapping %}
    {% do exceptions.raise_compiler_error("FAILED: 2nd argument " ~ expected ~ " is not a mapping.") %}
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
    {% if k not in value %}
      {% do exceptions.raise_compiler_error("FAILED: key " ~ k ~ " of 2nd argument is not in " ~ value ~ ".") %}
    {% endif %}

    {% if v is none and value[k] is not none %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}

    {% if v != value[k] %}
      {% do exceptions.raise_compiler_error("FAILED: values on the key " ~ k ~ " are not same.") %}
    {% endif %}
  {% endfor %}

  {% do log("SUCCESS") %}
{% endmacro %}
