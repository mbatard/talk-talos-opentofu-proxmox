# Upgrade Talos and Kubernetes

This directory keeps the upgrade parameters used by the demo scripts.

The real upgrade workflow is intentionally executed with `talosctl`:

- `talosctl upgrade` for Talos
- `talosctl upgrade-k8s` for Kubernetes

OpenTofu remains responsible for provisioning. Talos remains responsible for node and Kubernetes lifecycle operations.
