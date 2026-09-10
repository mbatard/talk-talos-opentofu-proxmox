#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
k8s_dir="${base_dir}/02-cilium-traefik"

cd "${base_dir}"

. .env

cd "${k8s_dir}"

tofu init

tofu destroy

rm -rf .terraform*
rm -f terraform.tfstate*
