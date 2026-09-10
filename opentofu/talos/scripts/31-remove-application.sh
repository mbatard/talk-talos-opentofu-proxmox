#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
app_dir="${base_dir}/03-deploy-application"
log_file="${base_dir}/scripts/talos-cluster.log"

cd "${app_dir}"

echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Remove whoami application" >> "${log_file}"

tofu destroy -auto-approve

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Remove whoami application" >> "${log_file}"
