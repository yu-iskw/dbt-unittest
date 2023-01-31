# dbt-unittest
This is a dbt package to enhance dbt package development by providing unit testing macros.

<!-- toc -->

- [Installation Instructions](#installation-instructions)
- [Requirements](#requirements)
- [Macros in the dbt package](#macros-in-the-dbt-package)
  * [`assert_true`](#assert_true)
  * [`assert_false`](#assert_false)
  * [`assert_is_none`](#assert_is_none)
  * [`assert_is_not_none`](#assert_is_not_none)
  * [`assert_equals`](#assert_equals)
  * [`assert_not_equals`](#assert_not_equals)
  * [`assert_in`](#assert_in)
  * [`assert_not_in`](#assert_not_in)
  * [`assert_list_equals`](#assert_list_equals)
  * [`assert_dict_equals`](#assert_dict_equals)

<!-- tocstop -->

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/yu-iskw/dbt_unittest/latest/) for the latest installation instructions.

## Requirements
- dbt-core: 1.0.0 or later

## Macros in the dbt package

### `assert_true`
Test that expr is true.

**Usage:**
```sql
  {{ dbt_unittest.assert_true(true) }}
  {{ dbt_unittest.assert_true(1 == 1) }}
```

### `assert_false`
Test that expr is false.

**Usage:**
```sql
  {{ dbt_unittest.assert_false(false) }}
  {{ dbt_unittest.assert_false(1 != 1) }}
```

### `assert_is_none`
Test that expr is None.

**Usage:**
```sql
  {{ dbt_unittest.assert_is_none(none) }}
```

### `assert_is_not_none`
Test that expr is not None.

**Usage:**
```sql
  {{ dbt_unittest.assert_is_not_none(none) }}
```

### `assert_equals`
Test that first and second are equal. 
If the values do not compare equal, the test will fail.

**Usage:**
```sql
  {{ dbt_unittest.assert_equals("foo", "bar") }}
```

### `assert_not_equals`
Test that first and second are not equal. 
If the values do compare equal, the test will fail.

**Usage:**
```sql
  {{ dbt_unittest.assert_not_equals("foo", "bar") }}
```

### `assert_in`
Test that member is in container.

**Usage:**
```sql
  {{ dbt_unittest.assert_in(1, [1, 2, 3]) }}
```

### `assert_not_in`
Test that member is not in container.

**Usage:**
```sql
  {{ dbt_unittest.assert_not_in(4, [1, 2, 3]) }}
```

### `assert_list_equals`
Tests that two lists are equal. 

**Usage:**
```sql
  {{ dbt_unittest.assert_list_equals([1, 2, 3], [4, 5]) }}
```

### `assert_dict_equals`
Test that two dictionaries are equal.

**Usage:**
```sql
  {{ dbt_unittest.assert_dict_equals({"k": 1}, {"k": 1}) }}
```

## Contributors
<!-- readme: contributors -start -->
<table>
<tr>
    <td align="center">
        <a href="https://github.com/yu-iskw">
            <img src="https://avatars.githubusercontent.com/u/1523515?v=4" width="100;" alt="yu-iskw"/>
            <br />
            <sub><b>Yu Ishikawa</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/dbeatty10">
            <img src="https://avatars.githubusercontent.com/u/44704949?v=4" width="100;" alt="dbeatty10"/>
            <br />
            <sub><b>Doug Beatty</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/ernestoongaro">
            <img src="https://avatars.githubusercontent.com/u/47784?v=4" width="100;" alt="ernestoongaro"/>
            <br />
            <sub><b>Ernesto Ongaro</b></sub>
        </a>
    </td>
    <td align="center">
        <a href="https://github.com/rlh1994">
            <img src="https://avatars.githubusercontent.com/u/8260415?v=4" width="100;" alt="rlh1994"/>
            <br />
            <sub><b>Ryan Hill</b></sub>
        </a>
    </td></tr>
</table>
<!-- readme: contributors -end -->
