#!/usr/bin/env bash

set -e

# Pull container
docker pull ${distribution}:${version}
