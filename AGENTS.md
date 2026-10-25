# dbt-unittest

Public dbt package named `dbt_unittest` (`dbt_project.yml`) that provides unit-testing macros for dbt package development. Implementations live under `macros/`; macro documentation YAML is under `docs/` (`docs/macros.yml`, `docs/comparisons.yml`).

## Requirements

- dbt-core ≥ 1.0.0 (`dbt_project.yml` `require-dbt-version`; `README.md` Requirements)

## Lint

- `make lint` — runs `pre-commit run --all-files` (`Makefile` `lint` target; hook list in `.pre-commit-config.yaml`; CI in `.github/workflows/lint.yml`)

## Integration tests

- DuckDB (no external services): from `integration_tests/`, `bash run_unit_tests.sh --target duckdb` (`integration_tests/README.md`; `integration_tests/run_unit_tests.sh`)
- Default target is `postgres` when `--target` is omitted (`integration_tests/run_unit_tests.sh`); GitHub Actions runs `bash run_unit_tests.sh` from `integration_tests/` with a Postgres service (`.github/workflows/unit-tests-core.yml`)
- Multiple dbt versions: from `integration_tests/`, `make test` (targets `test-dbt-1.8` through `test-dbt-1.11` in `integration_tests/Makefile`)

## When documentation and code disagree

When a repository's documentation and its existing code disagree, follow the conventions used in the existing code, and in your final reply point out each inconsistency you found between the documentation and the code.

"Documentation" includes this file, `CLAUDE.md`, editor rules, READMEs, `docs/`, ADRs, RFCs, and code comments. Treat what they say about the code as claims to check against the code, not as facts.

- **Documented target state wins only when it is explicit.** Follow the documentation instead of the code only when the documentation says the code is legacy or a migration is in progress. For example: a "migration in progress", "legacy", or "deprecated" marker, `@deprecated` on the code you would copy, or an ADR/RFC with status *Accepted* that is not superseded and is newer than the code it replaces. Ignore ADRs/RFCs that are *Proposed*, *Rejected*, *Deprecated*, or *Superseded*. Follow the superseding one.
- **When you can't tell which is current,** compare recency (`git log -1 --format=%cs -- <doc>` vs the code paths). Prefer the newer source, and say that you did. If the choice changes behavior and is still unclear, ask before proceeding.
- **Scope.** Apply the convention you choose to the code you are writing or changing. Don't rewrite working code, and don't edit documentation just to make the two agree, unless the task asks for it.
- **Process and safety rules still apply.** Commands to run, quality gates, review/merge rules, and security constraints in this file are not descriptions of the code. Follow them.
- **Report.** In your final reply (and in the PR description, if you open one), list each inconsistency: the document and section, what the code actually does, which one you followed, and why.
