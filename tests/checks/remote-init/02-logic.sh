#!/usr/bin/env bash

set -e

echo "remote-init :: Checking logic"

container_id=$(
  docker run \
    --detach \
    --volume="${PWD}/tests/ansible":/etc/ansible:rw \
    --volume="${PWD}/roles":/etc/ansible/roles:ro \
    --volume="${PWD}/tests/checks":/tmp/checks:ro \
    ${distribution}:${version}.ansible \
    /sbin/init
)

docker exec \
  "${container_id}" \
  /usr/bin/ansible-playbook /tmp/checks/remote-init/remote-init.yml

docker exec \
  "${container_id}" \
  /usr/bin/bats /tmp/checks/remote-init/logic.bats
