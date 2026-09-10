#
# Proxmox
#
variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type = string
}

variable "proxmox_bridge" {
  description = "Proxmox network bridge"
  type = string
}

variable "proxmox_vm_datastore" {
  description = "Proxmox datastore used for VM disks"
  type = string
}

variable "proxmox_import_datastore" {
  description = "Proxmox datastore used for the Talos image"
  type        = string
}

#
# Virtual machines
#
variable "vm_machine" {
  description = "Proxmox VM machine type"
  type        = string
}

variable "vm_bios" {
  description = "Proxmox VM BIOS"
  type        = string
}

variable "vm_cpu_type" {
  description = "Proxmox CPU type"
  type        = string
}

variable "vm_disk_interface" {
  description = "VM boot disk interface"
  type        = string
}

variable "vm_disk_format" {
  description = "VM boot disk format"
  type        = string
}

variable "vm_disk_size" {
  description = "VM boot disk size in GB"
  type        = number
}

variable "vm_started" {
  description = "Start VM after creation"
  type        = bool
}

variable "vm_on_boot" {
  description = "Start VM when Proxmox starts"
  type        = bool
}

variable "vm_agent_enabled" {
  description = "Enable QEMU Guest Agent"
  type        = bool
}

variable "vm_agent_trim" {
  description = "Enable fstrim through QEMU Guest Agent"
  type        = bool
}

#
# Network
#
variable "vm_domain" {
  description = "DNS domain used by the Talos nodes"
  type        = string
}

variable "vm_gateway" {
  description = "Default gateway used by Talos nodes"
  type        = string
}

variable "vm_dns" {
  description = "DNS servers used by Talos nodes"
  type        = list(string)
}

variable "vm_network" {
  description = "IPv4 network used by Talos nodes"
  type        = string
}

variable "vm_subnet_prefix" {
  description = "IPv4 subnet prefix length"
  type        = string
}

#
# Talos
#
variable "talos_version" {
  description = "Talos version, without the v prefix"
  type        = string
}

variable "talos_image_schema" {
  description = "Talos Image Factory schematic ID"
  type        = string
}

variable "talos_cluster_name" {
  description = "Talos cluster name"
  type        = string
}

variable "talos_cluster_endpoint" {
  description = "Talos control plane VIP"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "talos_install_disk" {
  description = "Disk where Talos is installed"
  type        = string
}

variable "talos_time_servers" {
  description = "NTP servers used by Talos"
  type        = list(string)
}

variable "talos_allow_scheduling_on_controlplanes" {
  description = "Allow workloads to run on control plane nodes"
  type        = bool
}

variable "talos_bootstrap_node" {
  description = "Key of the control plane node used for the initial Talos bootstrap"
  type        = string
  default     = "talos-cp-1"

  validation {
    condition     = contains(keys(local.all_nodes), var.talos_bootstrap_node)
    error_message = "talos_bootstrap_node must reference an existing key in local.all_nodes."
  }
}

variable "talos_api_cert_sans" {
  description = "Additional SANs for the Kubernetes API certificate"
  type        = list(string)
  default     = []
}

#
# Nodes
#
variable "nodes" {
  description = "Talos cluster nodes"

  type = map(object({
    role             = string
    vm_id            = number
    vm_ip            = string
    vm_cpu_cores     = number
    vm_memory        = number
    vm_startup_order = number
  }))
}

locals {
  all_nodes = var.nodes
}
