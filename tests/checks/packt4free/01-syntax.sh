#!/usr/bin/env bash

set -e

echo "packt4free :: Checking syntax"

docker run \
  --rm \
  --volume="${PWD}/tests/ansible":/etc/ansible:rw \
  --volume="${PWD}/roles":/etc/ansible/roles:ro \
  --volume="${PWD}/tests/checks":/tmp/checks:ro \
  ${distribution}:${version}.ansible \
  /usr/bin/ansible-playbook --syntax-check /tmp/checks/packt4free/packt4free.yml 1> /dev/null
