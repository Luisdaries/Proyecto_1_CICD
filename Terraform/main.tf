terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.6.14"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "Rocky9_1" {
  name = "Rocky9.qcow2"
  pool = "default"
  source = "/home/adan/Downloads/Rocky-9-GenericCloud.latest.x86_64.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "Rocky9_1" {
  name   = "terraform-vm"
  memory = 2048
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.Rocky9_1.id
  }

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  graphics {
    type = "spice"
  }
}
