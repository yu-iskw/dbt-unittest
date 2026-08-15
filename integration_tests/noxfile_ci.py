"""CI-only Nox sessions for dbt Core compatibility coverage."""

from __future__ import annotations

import shutil
from pathlib import Path

import nox

ROOT = Path(__file__).resolve().parent
WORK_ROOT = ROOT / ".ci-work"

nox.options.default_venv_backend = "uv"


def _run_core_tests(session: nox.Session, requirements_file: str) -> None:
    """Run one Python/dbt compatibility case in an isolated project copy."""
    session.install("-r", str(ROOT / "requirements" / requirements_file))

    workdir = WORK_ROOT / session.name
    if workdir.exists():
        shutil.rmtree(workdir)
    shutil.copytree(
        ROOT,
        workdir,
        ignore=shutil.ignore_patterns(".ci-work", "logs", "target", "dbt_packages"),
    )

    session.chdir(workdir)
    session.run("bash", "run_unit_tests.sh", external=True)


@nox.session(name="core_1_8", python=["3.9", "3.10", "3.11"])
def core_1_8(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.8.txt")


@nox.session(name="core_1_9", python=["3.10", "3.11"])
def core_1_9(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.9.txt")


@nox.session(name="core_1_10", python=["3.10", "3.11", "3.12"])
def core_1_10(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.10.txt")


@nox.session(name="core_1_11", python=["3.10", "3.11", "3.12"])
def core_1_11(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.11.txt")
