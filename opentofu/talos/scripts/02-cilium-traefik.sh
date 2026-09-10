#!/bin/bash

set -euo pipefail

talos_cluster_endpoint="10.10.10.10"

base_dir="$HOME/opentofu/talos"
k8s_dir="${base_dir}/02-cilium-traefik"
log_file="${base_dir}/scripts/talos-cluster.log"

#
# Load environment variables
#
cd "${base_dir}"
. .env

#
# Phase 2 : Kubernetes components
#
cd "${k8s_dir}"

tofu init

#
# Phase 2.1 : Cilium
#
echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Deploy Cilium" >> "${log_file}"

tofu plan \
  -target=helm_release.cilium

tofu apply -auto-approve \
  -target=helm_release.cilium

kubectl wait \
  --for=condition=Established \
  crd/ciliumloadbalancerippools.cilium.io \
  --timeout=120s

kubectl wait \
  --for=condition=Established \
  crd/ciliuml2announcementpolicies.cilium.io \
  --timeout=120s

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Deploy Cilium" >> "${log_file}"

sleep 20

cilium status

kubectl get nodes -o wide

kubectl get pods -A -o wide

echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Configure CoreDNS spreading" >> "${log_file}"

#
# Spread CoreDNS pods across different nodes
#
kubectl -n kube-system patch deployment coredns --type='strategic' -p '
spec:
  template:
    spec:
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: kubernetes.io/hostname
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              k8s-app: kube-dns
'

#
# Wait for rollout
#
kubectl -n kube-system rollout status deployment/coredns --timeout=120s

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Configure CoreDNS spreading" >> "${log_file}"

#
# Display placement
#
kubectl -n kube-system get pods -l k8s-app=kube-dns -o wide

#
# Phase 2.2 : Traefik
#
echo "$(date '+%Y-%m-%d %H:%M:%S') [START] Deploy Traefik" >> "${log_file}"

tofu plan

tofu apply -auto-approve

echo "$(date '+%Y-%m-%d %H:%M:%S') [END] Deploy Traefik" >> "${log_file}"

#
# Final diagnostics
#
kubectl get pods,svc -n traefik-system -o wide
