#
# Proxmox
#
proxmox_endpoint         = "https://10.10.10.1:8006/"
proxmox_node             = "ns3151356"
proxmox_bridge           = "vmbr1"
proxmox_vm_datastore     = "local"
proxmox_import_datastore = "local"

#
# Virtual machines
#
vm_machine        = "q35"
vm_bios           = "ovmf"
vm_cpu_type       = "host"
vm_disk_interface = "virtio0"
vm_disk_format    = "raw"
vm_disk_size      = 20
vm_started        = true
vm_on_boot        = true
vm_agent_enabled  = true
vm_agent_trim     = true

#
# Network
#
vm_domain        = "calmops.fr"
vm_gateway       = "10.10.10.1"
vm_dns           = ["213.186.33.99"]
vm_network       = "10.10.10.0"
vm_subnet_prefix = 24

#
# Talos
#
talos_cluster_name     = "talos"
talos_cluster_endpoint = "10.10.10.10"
talos_version          = "1.13.8"
talos_image_schema     = "88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b"
	# Extensions:
	# - siderolabs/iscsi-tools
	# - siderolabs/qemu-guest-agent
	# - siderolabs/util-linux-tools
talos_bootstrap_node   = "talos-cp-1"
talos_install_disk     = "/dev/vda"
talos_time_servers     = ["ntp.ovh.net"]
talos_api_cert_sans    = [] # Facultatif : SANs supplémentaires

talos_allow_scheduling_on_controlplanes = false

#
# Kubernetes
#
kubernetes_version     = "1.36.3"

#
# Talos nodes
#
nodes = {
  "talos-cp-1" = {
    role             = "controlplane"
    vm_id            = 101
    vm_ip            = "10.10.10.101"
    vm_cpu_cores     = 2
    vm_memory        = 4096
    vm_startup_order = 1
  }

  "talos-cp-2" = {
    role             = "controlplane"
    vm_id            = 102
    vm_ip            = "10.10.10.102"
    vm_cpu_cores     = 2
    vm_memory        = 4096
    vm_startup_order = 2
  }

  "talos-cp-3" = {
    role             = "controlplane"
    vm_id            = 103
    vm_ip            = "10.10.10.103"
    vm_cpu_cores     = 2
    vm_memory        = 4096
    vm_startup_order = 3
  }

  "talos-wkr-1" = {
    role             = "worker"
    vm_id            = 111
    vm_ip            = "10.10.10.111"
    vm_cpu_cores     = 8
    vm_memory        = 6144
    vm_startup_order = 4
  }
}
