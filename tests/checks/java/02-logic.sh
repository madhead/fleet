#!/usr/bin/env bash

set -e

echo "java :: Checking logic"

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
  /usr/bin/ansible-playbook /tmp/checks/java/java.yml

docker exec \
  "${container_id}" \
  /usr/bin/bats /tmp/checks/java/logic.bats
