#!/usr/bin/env bash

set -e

# Build new container with Ansible installed
docker build --rm=true --file=tests/docker_context/Dockerfile.${distribution}-${version} --tag=${distribution}:${version}.ansible tests/docker_context
