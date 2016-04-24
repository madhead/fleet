#!/usr/bin/env bash

set -e

# Delegate to other scripts
find ./tests/checks/ -name '*.sh' | sort -n | xargs -n 1 bash
