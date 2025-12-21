lint:
	pre-commit run --all-files

generate-toc:
	markdown-toc --maxdepth 3 -i README.md
