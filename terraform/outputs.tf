# Création d'une map pour faciliter le parsing par Ansible
output "proxmox_vms" {
  value = {
    "reverse_proxy" = {
        ip   = proxmox_vm_qemu.vm_reverse_proxy.default_ipv4_address
        name = proxmox_vm_qemu.vm_reverse_proxy.name
    }
    "appli" = {
        ip   = proxmox_vm_qemu.vm_appli.default_ipv4_address
        name = proxmox_vm_qemu.vm_appli.name
    }
    "supervision" = {
        ip   = proxmox_vm_qemu.vm_supervision.default_ipv4_address
        name = proxmox_vm_qemu.vm_supervision.name
    }
    "bastion" = {
        ip = proxmox_vm_qemu.vm_bastion.default_ipv4_address
        name = proxmox_vm_qemu.vm_bastion.name
    }
  }
}