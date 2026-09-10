#!/bin/bash

set -euo pipefail

base_dir="$HOME/opentofu/talos"
upgrade_dir="${base_dir}/05-upgrade-talos-and-k8s"

cd "${upgrade_dir}"
. ./upgrade.env

old_version="${KUBERNETES_OLD_VERSION}"
new_version="${KUBERNETES_NEW_VERSION}"

echo "Upgrade kubectl from ${old_version} to ${new_version}"
curl -LO https://dl.k8s.io/release/v${new_version}/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/release/v${new_version}/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl kubectl.sha256

node_name="${KUBERNETES_UPGRADE_NODE_NAME}"
node_ip="${KUBERNETES_UPGRADE_NODE_IP}"
echo "Upgrade Kubernetes from ${old_version} to ${new_version} on ${node_name} node"
kubectl get nodes ${node_name} -o wide
talosctl -n ${node_ip} upgrade-k8s --to ${new_version}
talosctl health -n ${node_ip}
kubectl get nodes ${node_name} -o wide
