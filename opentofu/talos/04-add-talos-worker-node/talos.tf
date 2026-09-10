data "talos_machine_configuration" "worker" {
  cluster_endpoint   = "https://${var.talos_cluster_endpoint}:6443"
  cluster_name       = var.talos_cluster_name
  kubernetes_version = var.kubernetes_version
  machine_secrets    = data.terraform_remote_state.cluster.outputs.talos_machine_secrets
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
                "${var.worker.vm_ip}/${var.vm_subnet_prefix}"
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

resource "talos_machine_configuration_apply" "worker" {
  depends_on = [
    proxmox_virtual_environment_vm.worker
  ]

  client_configuration        = data.terraform_remote_state.cluster.outputs.talos_client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = var.worker.vm_ip
}

data "talos_cluster_health" "worker" {
  depends_on = [
    talos_machine_configuration_apply.worker
  ]

  endpoints            = var.controlplane_nodes
  client_configuration = data.terraform_remote_state.cluster.outputs.talos_client_configuration
  control_plane_nodes  = var.controlplane_nodes
  worker_nodes         = [var.worker.vm_ip]

  # CNI / kubelet readiness is checked explicitly by the demo script after apply.
  skip_kubernetes_checks = true

  timeouts = {
    read = "10m"
  }
}
