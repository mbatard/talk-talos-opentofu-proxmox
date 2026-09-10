proxmox_endpoint         = "https://10.10.10.1:8006/"
proxmox_node             = "ns3151356"
proxmox_bridge           = "vmbr1"
proxmox_vm_datastore     = "local"
proxmox_import_datastore = "local"

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

vm_domain        = "calmops.fr"
vm_gateway       = "10.10.10.1"
vm_dns           = ["213.186.33.99"]
vm_network       = "10.10.10.0"
vm_subnet_prefix = 24

talos_cluster_name     = "talos"
talos_cluster_endpoint = "10.10.10.10"
talos_version          = "1.13.8"
talos_image_schema     = "88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b"
talos_install_disk     = "/dev/vda"
talos_time_servers     = ["ntp.ovh.net"]
kubernetes_version     = "1.36.3"

controlplane_nodes = [
  "10.10.10.101",
  "10.10.10.102",
  "10.10.10.103",
]

worker = {
  name         = "talos-wkr-2"
  vm_id        = 112
  vm_ip        = "10.10.10.112"
  vm_cpu_cores = 2
  vm_memory    = 4096
}
