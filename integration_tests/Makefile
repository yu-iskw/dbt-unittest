all: setup docker-up test docker-down

setup: setup-dbt-1.8 setup-dbt-1.9 setup-dbt-1.10

test: test-dbt-1.8 test-dbt-1.9 test-dbt-1.10

clean:
	rm -rf .venv-dbt-*
	rm -rf integration_tests.duckdb

docker-up:
	docker-compose up -d
	@echo "Waiting for PostgreSQL to be ready..."
	@timeout=60; \
	while [ $$timeout -gt 0 ]; do \
		if docker-compose exec -T postgres pg_isready -U postgres > /dev/null 2>&1; then \
			echo "PostgreSQL is ready!"; \
			break; \
		fi; \
		sleep 1; \
		timeout=$$((timeout - 1)); \
	done; \
	if [ $$timeout -eq 0 ]; then \
		echo "Warning: PostgreSQL health check timed out"; \
		exit 1; \
	fi

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f postgres

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
	uv pip install --python .venv-dbt-1.10/bin/python --pre -r requirements/requirements-1.10.txt
	uv run --python .venv-dbt-1.10/bin/python dbt deps --profiles-dir profiles

test-dbt-1.10:
	uv run --python .venv-dbt-1.10/bin/python bash -x run_unit_tests.sh
