This folder contains an example how to integrate dbt-unittest
within dbt's native testing framework. It allows to group multiple assert
statements into a single test, and get a combined pass/fail result.

This should make integration in a project that uses native dbt testing a bit more consistent.

The overall idea is to have:
- a wrapper model, that checks a bunch of asserts
- a yml file that defines a test that uses the wrapper model, and runs it via dbts testing framework
- a dummy_source model, becauste it is needed by dbt :/

## Running:
In the example, model files are in the same folder as the yml file. In a real project, dbt will only find them in its model folder, while the test should go into a test folder. So either change the `model-paths` in dbt_project.yml (likely undesired) or move them.

```
dbt build --select _dummy_source
dbt test --vars '{"raise_on_error": false}'
```
