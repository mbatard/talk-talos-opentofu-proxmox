#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
worker_dir="${base_dir}/04-add-talos-worker-node"
log_file="${base_dir}/scripts/talos-cluster.log"

#
# Load environment variables
#
cd "${base_dir}"
. .env

node_name="talos-wkr-2"
node_id="112"
node_ip="10.10.10.112"

echo
echo "========================================"
echo " Add Talos worker"
echo "========================================"
echo
echo "Node : ${node_name}"
echo "VM ID: ${node_id}"
echo "IP   : ${node_ip}"
echo

cd "${worker_dir}"

echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Add worker node in cluster : #${node_id} ${node_name} (${node_ip})" >> "${log_file}"

tofu init

tofu plan

tofu apply -auto-approve

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Add worker node in cluster : #${node_id} ${node_name} (${node_ip})" >> "${log_file}"

kubectl wait --for=condition=Ready "node/${node_name}" --timeout=5m

kubectl get nodes -o wide

talosctl -n 10.10.10.10 get members

echo
echo "========================================"
echo " Node ${node_name} successfully added"
echo "========================================"
