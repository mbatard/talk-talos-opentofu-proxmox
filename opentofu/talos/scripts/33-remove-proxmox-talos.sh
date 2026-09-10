#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
infra_dir="${base_dir}/01-proxmox-talos"

cd "${base_dir}"

. .env

cd "${infra_dir}"

tofu init

tofu destroy

rm -rf .terraform*
rm -f terraform.tfstate*

rm -f ~/.talos/config
rm -f ~/.kube/config
