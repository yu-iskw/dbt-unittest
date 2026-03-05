{% macro propagate_pass(message = 'Assertion passed') %}
select
  1 as assertion_passed,
  '{{ message }}' as message
{% endmacro %}
