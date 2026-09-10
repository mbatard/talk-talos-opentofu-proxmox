data "terraform_remote_state" "cluster" {
  backend = "local"

  config = {
    path = "../01-proxmox-talos/terraform.tfstate"
  }
}

resource "proxmox_download_file" "talos_image" {
  content_type = "import"

  datastore_id = var.proxmox_import_datastore
  node_name    = var.proxmox_node
  file_name    = "talos-v${var.talos_version}-nocloud-amd64.qcow2"
  url          = "https://factory.talos.dev/image/${var.talos_image_schema}/v${var.talos_version}/nocloud-amd64.qcow2"

  overwrite_unmanaged = true
}

resource "proxmox_virtual_environment_vm" "worker" {
  name        = var.worker.name
  description = "Talos worker node"
  vm_id       = var.worker.vm_id
  node_name   = var.proxmox_node
  tags        = ["talos", "kubernetes", "worker"]

  started         = var.vm_started
  on_boot         = var.vm_on_boot
  stop_on_destroy = true

  machine       = var.vm_machine
  bios          = var.vm_bios
  scsi_hardware = "virtio-scsi-pci"
  boot_order    = [var.vm_disk_interface]

  lifecycle {
    ignore_changes = [disk[0].import_from]
  }

  efi_disk {
    datastore_id      = var.proxmox_vm_datastore
    type              = "4m"
    pre_enrolled_keys = false
  }

  cpu {
    cores   = var.worker.vm_cpu_cores
    sockets = 1
    type    = var.vm_cpu_type
  }

  memory {
    dedicated = var.worker.vm_memory
  }

  disk {
    datastore_id = var.proxmox_vm_datastore
    import_from  = proxmox_download_file.talos_image.id
    interface    = var.vm_disk_interface
    file_format  = var.vm_disk_format
    size         = var.vm_disk_size
    aio          = "io_uring"
    cache        = "none"
    discard      = "on"
    iothread     = true
  }

  network_device {
    bridge = var.proxmox_bridge
    model  = "virtio"
  }

  initialization {
    datastore_id = var.proxmox_vm_datastore

    dns {
      domain  = var.vm_domain
      servers = var.vm_dns
    }

    ip_config {
      ipv4 {
        address = "${var.worker.vm_ip}/${var.vm_subnet_prefix}"
        gateway = var.vm_gateway
      }
    }
  }

  operating_system {
    type = "l26"
  }

  agent {
    enabled = var.vm_agent_enabled
    timeout = "5m"
    trim    = var.vm_agent_trim
  }
}
