#!/bin/bash
#
# Configure a linux server
#

set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"


export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -v -i hosts playbook.yml
