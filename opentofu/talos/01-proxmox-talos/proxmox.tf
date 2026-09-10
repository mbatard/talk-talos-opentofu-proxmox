#
# Talos image
#
resource "proxmox_download_file" "talos_image" {
  content_type = "import"

  datastore_id = var.proxmox_import_datastore
  node_name    = var.proxmox_node

  file_name = "talos-v${var.talos_version}-nocloud-amd64.qcow2"

  url = "https://factory.talos.dev/image/${var.talos_image_schema}/v${var.talos_version}/nocloud-amd64.qcow2"

  overwrite_unmanaged = true
}

#
# Talos virtual machines
#
resource "proxmox_virtual_environment_vm" "talos_vm" {
  for_each = local.all_nodes

  #
  # General
  #
  name        = each.key
  description = "Talos ${each.value.role} node"
  vm_id       = each.value.vm_id
  node_name   = var.proxmox_node
  tags = [
    "talos",
    "kubernetes",
    each.value.role
  ]

  started         = var.vm_started
  on_boot         = var.vm_on_boot
  stop_on_destroy = true

  #
  # Hardware
  #
  machine       = var.vm_machine
  bios          = var.vm_bios
  scsi_hardware = "virtio-scsi-pci"

  boot_order = [var.vm_disk_interface]

  #
  # Ignore import_from after initial disk import
  #
  lifecycle {
    ignore_changes = [
      disk[0].import_from
    ]
  }

  #
  # UEFI
  #
  efi_disk {
    datastore_id      = var.proxmox_vm_datastore
    type              = "4m"
    pre_enrolled_keys = false
  }

  #
  # CPU
  #
  cpu {
    cores   = each.value.vm_cpu_cores
    sockets = 1
    type    = var.vm_cpu_type
  }

  #
  # Memory
  #
  memory {
    dedicated = each.value.vm_memory
  }

  #
  # Boot disk
  #
  disk {
    datastore_id = var.proxmox_vm_datastore
    import_from  = proxmox_download_file.talos_image.id

    interface   = var.vm_disk_interface
    file_format = var.vm_disk_format
    size        = var.vm_disk_size

    aio      = "io_uring"
    cache    = "none"
    discard  = "on"
    iothread = true
  }

  #
  # Network
  #
  network_device {
    bridge = var.proxmox_bridge
    model  = "virtio"
  }

  #
  # NoCloud initialization
  #
  initialization {
    datastore_id = var.proxmox_vm_datastore

    dns {
      domain  = var.vm_domain
      servers = var.vm_dns
    }

    ip_config {
      ipv4 {
        address = "${each.value.vm_ip}/${var.vm_subnet_prefix}"
        gateway = var.vm_gateway
      }
    }
  }

  #
  # OS
  #
  operating_system {
    type = "l26"
  }

  #
  # Agent
  #
  agent {
    enabled = var.vm_agent_enabled
    timeout = "5m"
    trim    = var.vm_agent_trim
  }
}
