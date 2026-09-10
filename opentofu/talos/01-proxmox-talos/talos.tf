locals {
  controlplane_nodes = {
    for key, node in local.all_nodes :
    key => node
    if node.role == "controlplane"
  }

  worker_nodes = {
    for key, node in local.all_nodes :
    key => node
    if node.role == "worker"
  }

  controlplane_ips = [
    for node in values(local.controlplane_nodes) :
    node.vm_ip
  ]

  worker_ips = [
    for node in values(local.worker_nodes) :
    node.vm_ip
  ]
}

#
# Talos secrets
#
resource "talos_machine_secrets" "this" {}

#
# Control plane configuration
#
data "talos_machine_configuration" "controlplane" {
  for_each = local.controlplane_nodes

  cluster_endpoint   = "https://${var.talos_cluster_endpoint}:6443"
  cluster_name       = var.talos_cluster_name
  kubernetes_version = var.kubernetes_version
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  machine_type       = "controlplane"
  talos_version      = var.talos_version

  config_patches = [
    yamlencode({
      machine = {
        kubelet = {
          nodeIP = {
            validSubnets = [
              "${var.vm_network}/${var.vm_subnet_prefix}"
            ]
          }

          extraConfig = {
            imageGCHighThresholdPercent = 70
            imageGCLowThresholdPercent  = 60
            imageMinimumGCAge           = "2m"
          }
        }

        features = {
          hostDNS = {
            enabled              = true
            forwardKubeDNSToHost = false
            resolveMemberNames   = true
          }
        }

        network = {
          nameservers = var.vm_dns

          interfaces = [
            {
              interface = "eth0"
              dhcp      = false

              addresses = [
                "${each.value.vm_ip}/${var.vm_subnet_prefix}"
              ]

              vip = {
                ip = var.talos_cluster_endpoint
              }

              routes = [
                {
                  network = "0.0.0.0/0"
                  gateway = var.vm_gateway
                }
              ]
            }
          ]
        }

        install = {
          disk = var.talos_install_disk

          extraKernelArgs = [
            "net.ifnames=0"
          ]
        }

        time = {
          servers = var.talos_time_servers
        }
      }

      cluster = {
        etcd = {
          advertisedSubnets = [
            "${var.vm_network}/${var.vm_subnet_prefix}"
          ]
        }

        discovery = {
          enabled = true
        }

        network = {
          cni = {
            name = "none"
          }
        }

        proxy = {
          disabled = true
        }

        allowSchedulingOnControlPlanes = var.talos_allow_scheduling_on_controlplanes

        apiServer = {
          certSANs = distinct(
            concat(
              [
                var.talos_cluster_endpoint,
                each.value.vm_ip,
                "127.0.0.1"
              ],
              var.talos_api_cert_sans
            )
          )
        }
      }
    })
  ]
}

#
# Apply control plane configuration
#
resource "talos_machine_configuration_apply" "controlplane" {
  depends_on = [
    proxmox_virtual_environment_vm.talos_vm
  ]

  for_each = data.talos_machine_configuration.controlplane

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = each.value.machine_configuration
  node                        = local.all_nodes[each.key].vm_ip
}

#
# Worker configuration
#
data "talos_machine_configuration" "worker" {
  for_each = local.worker_nodes

  cluster_endpoint   = "https://${var.talos_cluster_endpoint}:6443"
  cluster_name       = var.talos_cluster_name
  kubernetes_version = var.kubernetes_version
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  machine_type       = "worker"
  talos_version      = var.talos_version

  config_patches = [
    yamlencode({
      machine = {
        kubelet = {
          nodeIP = {
            validSubnets = [
              "${var.vm_network}/${var.vm_subnet_prefix}"
            ]
          }

          extraConfig = {
            imageGCHighThresholdPercent = 70
            imageGCLowThresholdPercent  = 60
            imageMinimumGCAge           = "2m"
          }
        }

        features = {
          hostDNS = {
            enabled              = true
            forwardKubeDNSToHost = false
            resolveMemberNames   = true
          }
        }

        network = {
          nameservers = var.vm_dns

          interfaces = [
            {
              interface = "eth0"
              dhcp      = false

              addresses = [
                "${each.value.vm_ip}/${var.vm_subnet_prefix}"
              ]

              routes = [
                {
                  network = "0.0.0.0/0"
                  gateway = var.vm_gateway
                }
              ]
            }
          ]
        }

        install = {
          disk = var.talos_install_disk

          extraKernelArgs = [
            "net.ifnames=0"
          ]
        }
        time = {
          servers = var.talos_time_servers
        }
      }
    })
  ]
}

#
# Apply worker configuration
#
resource "talos_machine_configuration_apply" "worker" {
  depends_on = [
    proxmox_virtual_environment_vm.talos_vm
  ]

  for_each = data.talos_machine_configuration.worker

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = each.value.machine_configuration
  node                        = local.all_nodes[each.key].vm_ip
}

#
# talosctl configuration
#
data "talos_client_configuration" "this" {
  cluster_name         = var.talos_cluster_name
  endpoints            = local.controlplane_ips
  client_configuration = talos_machine_secrets.this.client_configuration
}

#
# Bootstrap etcd / Kubernetes
#
resource "talos_machine_bootstrap" "this" {
  depends_on = [
    talos_machine_configuration_apply.controlplane
  ]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.all_nodes[var.talos_bootstrap_node].vm_ip
}

#
# Talos cluster health
#
data "talos_cluster_health" "this" {
  depends_on = [
    talos_machine_configuration_apply.controlplane,
    talos_machine_configuration_apply.worker,
    talos_machine_bootstrap.this
  ]

  endpoints            = local.controlplane_ips
  client_configuration = data.talos_client_configuration.this.client_configuration

  control_plane_nodes = local.controlplane_ips
  worker_nodes        = local.worker_ips

  #
  # Kubernetes is not fully operational yet because
  # Cilium is installed afterwards.
  #
  skip_kubernetes_checks = true

  timeouts = {
    read = "10m"
  }
}

#
# Kubernetes kubeconfig
#
resource "talos_cluster_kubeconfig" "this" {
  depends_on = [
    talos_machine_bootstrap.this,
    data.talos_cluster_health.this
  ]

  client_configuration = talos_machine_secrets.this.client_configuration

  endpoint = var.talos_cluster_endpoint
  node     = local.all_nodes[var.talos_bootstrap_node].vm_ip

  timeouts = {
    read = "1m"
  }
}

#
# Outputs
#
output "talosconfig" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true # Empêche l'affichage en clair dans les logs
}

output "talos_client_configuration" {
  value     = talos_machine_secrets.this.client_configuration
  sensitive = true
}

output "talos_machine_secrets" {
  value     = talos_machine_secrets.this.machine_secrets
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true # Empêche l'affichage en clair dans les logs
}
