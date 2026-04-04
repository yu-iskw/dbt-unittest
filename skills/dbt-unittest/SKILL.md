---
name: dbt-unittest
description: >-
  Helps dbt developers write and run unit tests for dbt macros using the
  dbt-unittest package. Use this skill when writing tests for custom dbt macros,
  creating assertion-based test files, verifying macro output correctness, or
  setting up a unit testing workflow for a dbt package.
compatibility: Requires dbt-core >= 1.0.0. Works with all dbt adapters (PostgreSQL, DuckDB, BigQuery, Snowflake, etc.).
metadata:
  package: yu-iskw/dbt_unittest
  version: "0.3.3"
  hub-url: https://hub.getdbt.com/yu-iskw/dbt_unittest/latest/
  repository: https://github.com/yu-iskw/dbt-unittest
allowed-tools: Read Bash Glob Grep
---

# dbt-unittest

`dbt-unittest` is a dbt package that brings Python-style unit testing macros to dbt macro
development. It provides assertion macros (raise a compiler error on failure) and comparison
macros (return a boolean) that let you verify macro logic inside `dbt run-operation` test files.

## Installation

Add the package to your project's `packages.yml`:

```yaml
packages:
  - package: yu-iskw/dbt_unittest
    version: [">=0.3.3"]
```

Then install dependencies:

```bash
dbt deps
```

## Test File Structure

Create a macro in your project that calls the assertion macros, then run it with
`dbt run-operation`:

```sql
-- macros/tests/test_my_macro.sql
{% macro test_my_macro() %}
  {{ dbt_unittest.assert_equals(my_package.my_macro("input"), "expected output") }}
  {{ dbt_unittest.assert_true(my_package.returns_bool()) }}
{% endmacro %}
```

Run the test:

```bash
dbt run-operation test_my_macro
```

A passing test produces no output. A failing assertion raises a `dbt.exceptions.CompilationError`
with a descriptive message and exits with a non-zero status code.

## Assertion Macros

Assertion macros fail loudly (compiler error) when the condition is not met. Use these to make
test failures immediately visible.

### `assert_true`

Test that `condition` evaluates to `true`.

```sql
{{ dbt_unittest.assert_true(true) }}
{{ dbt_unittest.assert_true(1 == 1) }}
```

### `assert_false`

Test that `condition` evaluates to `false`.

```sql
{{ dbt_unittest.assert_false(false) }}
{{ dbt_unittest.assert_false(1 != 1) }}
```

### `assert_is_none`

Test that `value` is `none`.

```sql
{{ dbt_unittest.assert_is_none(none) }}
```

### `assert_is_not_none`

Test that `value` is not `none`.

```sql
{{ dbt_unittest.assert_is_not_none("hello") }}
```

### `assert_equals`

Test that `actual` and `expected` are equal.

```sql
{{ dbt_unittest.assert_equals("foo", "foo") }}
{{ dbt_unittest.assert_equals(42, 42) }}
```

### `assert_not_equals`

Test that `actual` and `unexpected` are not equal.

```sql
{{ dbt_unittest.assert_not_equals("foo", "bar") }}
```

### `assert_in`

Test that `value` is a member of `container`.

```sql
{{ dbt_unittest.assert_in(1, [1, 2, 3]) }}
{{ dbt_unittest.assert_in("b", ["a", "b", "c"]) }}
```

### `assert_not_in`

Test that `value` is not a member of `container`.

```sql
{{ dbt_unittest.assert_not_in(4, [1, 2, 3]) }}
```

### `assert_list_equals`

Test that two lists are equal (supports nested lists and dicts).

```sql
{{ dbt_unittest.assert_list_equals([1, 2, 3], [1, 2, 3]) }}
{{ dbt_unittest.assert_list_equals([{"k": 1}], [{"k": 1}]) }}
```

### `assert_dict_equals`

Test that two dictionaries are equal (supports nested structures).

```sql
{{ dbt_unittest.assert_dict_equals({"key": "value"}, {"key": "value"}) }}
{{ dbt_unittest.assert_dict_equals({"a": [1, 2]}, {"a": [1, 2]}) }}
```

## Comparison Macros

Comparison macros return a boolean value instead of raising an error. Use them for conditional
logic in tests or to build custom assertions.

### `equals` / `not_equals`

```sql
{% set result = dbt_unittest.equals(1, 1) %}       {# true #}
{% set result = dbt_unittest.not_equals(1, 2) %}   {# true #}
```

### `contains` / `not_in`

```sql
{% set result = dbt_unittest.contains(1, [1, 2, 3]) %}  {# true #}
{% set result = dbt_unittest.not_in(4, [1, 2, 3]) %}    {# true #}
```

### `is_true` / `is_false`

```sql
{% set result = dbt_unittest.is_true(true) %}    {# true #}
{% set result = dbt_unittest.is_false(false) %}  {# true #}
```

### `is_none` / `is_not_none`

```sql
{% set result = dbt_unittest.is_none(none) %}      {# true #}
{% set result = dbt_unittest.is_not_none("hi") %}  {# true #}
```

### `list_equals` / `dict_equals`

```sql
{% set result = dbt_unittest.list_equals([1, 2], [1, 2]) %}             {# true #}
{% set result = dbt_unittest.dict_equals({"a": 1}, {"a": 1}) %}         {# true #}
```

## Running Tests

### Single test macro

```bash
dbt run-operation test_my_macro
```

### Master test orchestrator pattern

Create a single macro that calls all test macros in the project:

```sql
-- macros/tests/test_all.sql
{% macro test_all() %}
  {{ test_string_macros() }}
  {{ test_date_macros() }}
  {{ test_numeric_macros() }}
{% endmacro %}
```

Run all tests at once:

```bash
dbt run-operation test_all
```

### CI integration

```yaml
# .github/workflows/test.yml
- name: Run unit tests
  run: dbt run-operation test_all
```

## Example: Complete Test File

```sql
-- macros/tests/test_format_name.sql
{% macro test_format_name() %}

  {# Test basic concatenation #}
  {{ dbt_unittest.assert_equals(
      my_pkg.format_name("Alice", "Smith"),
      "Alice Smith"
  ) }}

  {# Test with none handling #}
  {{ dbt_unittest.assert_is_not_none(my_pkg.format_name("Alice", none)) }}

  {# Test output is a string #}
  {% set name = my_pkg.format_name("Bob", "Jones") %}
  {{ dbt_unittest.assert_true(name is string) }}

  {# Use comparison macro for conditional check #}
  {% if dbt_unittest.equals(name, "Bob Jones") %}
    {{ log("Name formatted correctly", info=true) }}
  {% endif %}

{% endmacro %}
```

## Best Practices

- **One concern per test macro**: keep each `test_*.sql` file focused on a single macro or
  behavior so failures are easy to locate.
- **Test both happy path and edge cases**: test `none` inputs, empty lists, nested structures.
- **Use descriptive macro names**: `test_format_name_with_none_suffix` beats `test_format_name2`.
- **Prefer assertion macros over comparison macros** in test files; assertion macros produce
  clear compiler errors that surface immediately in CI logs.
- **Combine into a master orchestrator**: a single `test_all` macro lets CI run every test with
  one command.
- **Co-locate tests with macros**: put test files in `macros/tests/` mirroring your `macros/`
  directory layout.
