#!/bin/bash
set -e

# Prevent git dubious ownership errors inside Docker containers
git config --global --add safe.directory '*'

if [ -d "/github/workspace" ]; then
    cd /github/workspace
fi

exec python3 /action/src/analyze.py "$@"
