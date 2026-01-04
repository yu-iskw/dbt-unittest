{% macro propagate_fail(message = 'Assertion failed') %}
select
  0 as assertion_passed,
  '{{ message }}' as message
{% endmacro %}
