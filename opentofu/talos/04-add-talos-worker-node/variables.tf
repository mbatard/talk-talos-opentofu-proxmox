variable "proxmox_endpoint" { type = string }
variable "proxmox_node" { type = string }
variable "proxmox_bridge" { type = string }
variable "proxmox_vm_datastore" { type = string }
variable "proxmox_import_datastore" { type = string }

variable "vm_machine" { type = string }
variable "vm_bios" { type = string }
variable "vm_cpu_type" { type = string }
variable "vm_disk_interface" { type = string }
variable "vm_disk_format" { type = string }
variable "vm_disk_size" { type = number }
variable "vm_started" { type = bool }
variable "vm_on_boot" { type = bool }
variable "vm_agent_enabled" { type = bool }
variable "vm_agent_trim" { type = bool }

variable "vm_domain" { type = string }
variable "vm_gateway" { type = string }
variable "vm_dns" { type = list(string) }
variable "vm_network" { type = string }
variable "vm_subnet_prefix" { type = string }

variable "talos_cluster_name" { type = string }
variable "talos_cluster_endpoint" { type = string }
variable "talos_version" { type = string }
variable "talos_image_schema" { type = string }
variable "talos_install_disk" { type = string }
variable "talos_time_servers" { type = list(string) }
variable "kubernetes_version" { type = string }

variable "worker" {
  type = object({
    name         = string
    vm_id        = number
    vm_ip        = string
    vm_cpu_cores = number
    vm_memory    = number
  })
}

variable "controlplane_nodes" {
  type = list(string)
}
