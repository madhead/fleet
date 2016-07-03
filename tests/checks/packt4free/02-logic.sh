#!/usr/bin/env bash

set -e

echo "packt4free :: Checking logic"

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
  /usr/sbin/useradd madhead

docker exec \
  "${container_id}" \
  /usr/bin/ansible-playbook /tmp/checks/packt4free/packt4free.yml

docker exec \
  "${container_id}" \
  /usr/bin/bats /tmp/checks/packt4free/logic.bats
