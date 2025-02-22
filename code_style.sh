#! /usr/bin/env bash
# Sort imports and run pylint, recurse on entire src/ directory.
# Assumes the Python project uses the `uv` package manager and
# ensures `isort` and `pylint` are available in the virtual environment. 
#
# Copy this script to some directory on your $PATH, e.g. $HOME/bin

GIT_ROOT=$(git rev-parse --show-toplevel)

uv add --dev isort pylint autopep8
uv run isort $GIT_ROOT/src/ -l 100 --project cam_ifm_dt_demo
uv run pylint $GIT_ROOT/src/
