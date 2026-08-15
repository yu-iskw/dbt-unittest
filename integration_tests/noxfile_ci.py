"""Nox sessions for the complete dbt compatibility suite."""

from __future__ import annotations

import os
import shutil
from pathlib import Path

import nox

ROOT = Path(__file__).resolve().parent
WORK_ROOT = ROOT / ".ci-work"
FUSION_PYTHON = "3.12"

nox.options.default_venv_backend = "uv"
nox.options.download_python = "auto"
nox.options.reuse_venv = "yes"


def _prepare_workdir(session: nox.Session) -> Path:
    """Create an isolated dbt project copy for a compatibility session."""
    workdir = WORK_ROOT / session.name
    if workdir.exists():
        shutil.rmtree(workdir)
    shutil.copytree(
        ROOT,
        workdir,
        ignore=shutil.ignore_patterns(".ci-work", "logs", "target", "dbt_packages"),
    )
    return workdir


def _run_core_tests(session: nox.Session, requirements_file: str) -> None:
    """Run one Python/dbt Core compatibility case."""
    session.install("-r", str(ROOT / "requirements" / requirements_file))
    session.chdir(_prepare_workdir(session))
    session.run("bash", "run_unit_tests.sh", external=True)


@nox.session(name="core_1_8", python=["3.9", "3.10", "3.11"], tags=["ci"])
def core_1_8(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.8.txt")


@nox.session(name="core_1_9", python=["3.10", "3.11"], tags=["ci"])
def core_1_9(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.9.txt")


@nox.session(name="core_1_10", python=["3.10", "3.11", "3.12"], tags=["ci"])
def core_1_10(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.10.txt")


@nox.session(name="core_1_11", python=["3.10", "3.11", "3.12"], tags=["ci"])
def core_1_11(session: nox.Session) -> None:
    _run_core_tests(session, "requirements-1.11.txt")


@nox.session(name="fusion", python=FUSION_PYTHON, tags=["ci"])
def fusion(session: nox.Session) -> None:
    """Install dbt Fusion into this virtualenv and run the unit tests."""
    install_env = {
        "DBT_FUSION_BIN_DIR": str(session.bin),
        "DBT_FUSION_BINARY_NAME": "dbt",
        "DBT_FUSION_VERSION": os.environ.get("DBT_FUSION_VERSION", ""),
    }
    session.run(
        "bash",
        str(ROOT / "scripts" / "ensure_fusion_backend.sh"),
        "--install-runtime",
        "--verify-runtime",
        env=install_env,
        external=True,
    )
    session.chdir(_prepare_workdir(session))
    session.run("bash", "run_unit_tests.sh", "--target", "postgres", external=True)
