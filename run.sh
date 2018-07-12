#!/bin/bash
#
# Configure a linux server
#

set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"

HOSTS_FILE=hosts
CLOUD_INIT_RESULT_FILE=/var/lib/cloud/data/result.json

if [[ ! -f "${HOSTS_FILE}" ]]; then
    echo "Hosts file missing"
    exit 1
fi

HOST="$(grep -v '\[servers\]' "${HOSTS_FILE}")"
NUM_HOSTS="$(echo "${HOST}" | wc -l)"
if [[ "$NUM_HOSTS" != 1 ]]; then
    echo "Expected 1 host but found ${NUM_HOSTS}:"
    echo "${HOST}"
    exit 1
fi

# Server IP is expected to change
ssh-keygen -R "${HOST}"

# Wait for cloud init to complete
while ! ssh "${HOST}" "[[ -f ${CLOUD_INIT_RESULT_FILE} ]]"; do
    echo "Waiting for ssh to come up"
    sleep 10
done

# Verify cloud init was successful
CLOUD_INIT_RESULT="$(ssh "${HOST}" "cat ${CLOUD_INIT_RESULT_FILE}")"
NUM_CLOUD_INIT_ERRORS="$(echo "${CLOUD_INIT_RESULT}" | jq '.v1.errors | length')"
if [[ "${NUM_CLOUD_INIT_ERRORS}" != 0 ]]; then
    echo "Cloud init failure"
    echo "${CLOUD_INIT_RESULT}"
    exit 1
fi

export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -v -i "${HOSTS_FILE}" playbook.yml
