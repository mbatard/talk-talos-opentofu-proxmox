#!/bin/bash

set -euo pipefail

talos_cluster_endpoint="10.10.10.10"

base_dir="$HOME/opentofu/talos"
infra_dir="${base_dir}/01-proxmox-talos"
log_file="${base_dir}/scripts/talos-cluster.log"

mkdir -p ~/.talos ~/.kube

#
# Load environment variables
#
cd "${base_dir}"
. .env

#
# Phase 1 : Proxmox + Talos
#
echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Create Talos cluster" > "${log_file}"

cd "${infra_dir}"

tofu init

tofu plan

tofu apply -auto-approve

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Create Talos cluster" >> "${log_file}"

#
# Export kubeconfig / talosconfig
#
tofu output -raw kubeconfig > ~/.kube/config
chmod 600 ~/.kube/config

tofu output -raw talosconfig > ~/.talos/config
chmod 600 ~/.talos/config

#
# First diagnostics
#
talosctl -n "${talos_cluster_endpoint}" get members

kubectl get nodes || true
