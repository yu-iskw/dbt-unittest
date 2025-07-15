
-- Collect all assertion results
with assertion_results as (
  {{ dbt_unittest.assert_true(1 == 1) }}

  union all

  {{ dbt_unittest.assert_true(2 == 1) }}

  union all

  {{ dbt_unittest.assert_true(3 == 3) }}
),

-- most likely, the test summary and output should also become a macro.
test_summary as (
  select
    (select min(assertion_passed) from assertion_results) as all_passed,
    string_agg(message, '; ') as message
  from assertion_results
  where assertion_passed != 1
)

select
  all_passed,
  message
from test_summary
