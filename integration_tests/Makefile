all: setup test

setup: setup-dbt-1.8 setup-dbt-1.9 setup-dbt-1.10 setup-dbt-1.11

test: test-dbt-1.8 test-dbt-1.9 test-dbt-1.10 test-dbt-1.11

clean:
	rm -rf .venv-dbt-*
	rm -rf integration_tests.duckdb

setup-dbt-1.8:
	uv venv --allow-existing .venv-dbt-1.8/
	uv pip install --python .venv-dbt-1.8/bin/python -r requirements/requirements-1.8.txt
	uv run --python .venv-dbt-1.8/bin/python dbt deps --profiles-dir profiles

test-dbt-1.8:
	uv run --python .venv-dbt-1.8/bin/python bash -x run_unit_tests.sh

setup-dbt-1.9:
	uv venv --allow-existing .venv-dbt-1.9/
	uv pip install --python .venv-dbt-1.9/bin/python -r requirements/requirements-1.9.txt
	uv run --python .venv-dbt-1.9/bin/python dbt deps --profiles-dir profiles

test-dbt-1.9:
	uv run --python .venv-dbt-1.9/bin/python bash -x run_unit_tests.sh

setup-dbt-1.10:
	uv venv --allow-existing .venv-dbt-1.10/
	uv pip install --python .venv-dbt-1.10/bin/python -r requirements/requirements-1.10.txt
	uv run --python .venv-dbt-1.10/bin/python dbt deps --profiles-dir profiles

test-dbt-1.10:
	uv run --python .venv-dbt-1.10/bin/python bash -x run_unit_tests.sh

setup-dbt-1.11:
	uv venv --allow-existing .venv-dbt-1.11/
	uv pip install --python .venv-dbt-1.11/bin/python -r requirements/requirements-1.11.txt
	uv run --python .venv-dbt-1.11/bin/python dbt deps --profiles-dir profiles

test-dbt-1.11:
	uv run --python .venv-dbt-1.11/bin/python bash -x run_unit_tests.sh
