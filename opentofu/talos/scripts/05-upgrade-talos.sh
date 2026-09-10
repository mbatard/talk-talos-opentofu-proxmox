#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
upgrade_dir="${base_dir}/05-upgrade-talos-and-k8s"

cd "${upgrade_dir}"
. ./upgrade.env

old_version="${TALOS_OLD_VERSION}"
new_version="${TALOS_NEW_VERSION}"

echo "Upgrade talosctl from ${old_version} to ${new_version}"
curl -L https://github.com/siderolabs/talos/releases/download/v${new_version}/talosctl-linux-amd64 -o talosctl
install -o root -g root -m 0755 talosctl /usr/local/bin/talosctl
rm -f talosctl

talos_image_schema="${TALOS_IMAGE_SCHEMA}"
image="factory.talos.dev/nocloud-installer/${talos_image_schema}:v${new_version}"

node_name="${TALOS_UPGRADE_NODE_NAME}"
node_ip="${TALOS_UPGRADE_NODE_IP}"
echo "Upgrade talos from ${old_version} to ${new_version} on ${node_name} node"
kubectl get nodes ${node_name} -o wide
talosctl upgrade -n ${node_ip} --image ${image} --preserve
talosctl health -n ${node_ip}
kubectl get nodes ${node_name} -o wide
