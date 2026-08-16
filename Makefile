lint:
	pre-commit run --all-files

generate-toc:
	markdown-toc --maxdepth 3 -i README.md

.PHONY: test-all
test-all:
	bash integration_tests/scripts/run_with_postgres_container.sh \
		uv run --with "nox[uv]==2026.7.11" bash ../dev/test_all.sh
