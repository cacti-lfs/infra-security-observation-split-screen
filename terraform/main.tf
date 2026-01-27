terraform{
    required_providers {
        proxmox = {
            version = "3.0.2-rc06"
            source = "Telmate/proxmox"
        }
    }
}
provider "proxmox" {
    pm_api_url = var.endpoint_proxmox

    pm_api_token_id= var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret

    pm_tls_insecure = true
}

# VM Reverse Proxy + Firewall
resource "proxmox_vm_qemu" "vm_reverse_proxy" {
    # Nom de la VM
    name = "01-SRV-RVPRX-TRIX" # A personnaliser
    vmid = 200
    target_node = "proxmox"
    
    # Nom du template exact du template Proxmox
    clone = "debian-13.3.0-cloud-template" # A personnaliser

    # Type de clone (full#linked)
    full_clone= true

    # Configuration système (DOIT être cohérent avec template)
    agent = 1
    os_type = "cloud-init"

    # Création du compte local
    ciuser = "cloudadm"
    cipassword = var.cloudadm_password

    # Ressources (Possibilité de surcharger les valeurs du template ici)
    cpu {
        type = "host"
        cores = 1
        sockets = 1
    }
    memory = 2048

    # Réseau
    network {
        model = "virtio"
        bridge = "vmbr0"
        id = 0
    }
    skip_ipv6 = true
    # Disque
    # Spécifier taille + stockage pour que Terraform sache où mettre le clone
    disk {
        slot = "scsi0"
        size = "25"
        type = "disk"
        storage = "local-lvm"
    }
    vga {
        type = "std"
    }
    # Ordre du boot
    boot = "order=scsi0;net0"

    # cloud-init
    ipconfig0 = "ip=dhcp"

    # Configuration SSH
    sshkeys = trimspace(var.ssh_rsa_key)
}

# VM Applicatif
resource "proxmox_vm_qemu" "vm_appli" {
    # Nom de la VM
    name = "01-SRV-APPLI-TRIX" # A personnaliser
    vmid = 201
    target_node = "proxmox"
    
    # Nom du template exact du template Proxmox
    clone = "debian-13.3.0-cloud-template" # A personnaliser

    # Type de clone (full#linked)
    full_clone= true

    # Configuration système (DOIT être cohérent avec template)
    agent = 1
    os_type = "cloud-init"

    # Création du compte local
    ciuser = "cloudadm"
    cipassword = var.cloudadm_password

    # Ressources (Possibilité de surcharger les valeurs du template ici)
    cpu {
        type = "host"
        cores = 1
        sockets = 1
    }
    memory = 2048

    # Réseau
    network {
        model = "virtio"
        bridge = "vmbr0"
        id = 0
    }
    skip_ipv6 = true
    # Disque
    # Spécifier taille + stockage pour que Terraform sache où mettre le clone
    disk {
        slot = "scsi0"
        size = "25"
        type = "disk"
        storage = "local-lvm"
    }
    vga {
        type = "std"
    }
    # Ordre du boot
    boot = "order=scsi0;net0"

    # cloud-init
    ipconfig0 = "ip=dhcp"

    # Configuration SSH
    sshkeys = trimspace(var.ssh_rsa_key)
}

# VM Supervision
resource "proxmox_vm_qemu" "vm_supervision" {
    # Nom de la VM
    name = "01-SRV-SUP-TRIX" # A personnaliser
    vmid = 202
    target_node = "proxmox"
    
    # Nom du template exact du template Proxmox
    clone = "debian-13.3.0-cloud-template" # A personnaliser

    # Type de clone (full#linked)
    full_clone= true

    # Configuration système (DOIT être cohérent avec template)
    agent = 1
    os_type = "cloud-init"

    # Création du compte local
    ciuser = "cloudadm"
    cipassword = var.cloudadm_password

    # Ressources (Possibilité de surcharger les valeurs du template ici)
    cpu {
        type = "host"
        cores = 1
        sockets = 1
    }
    memory = 2048

    # Réseau
    network {
        model = "virtio"
        bridge = "vmbr0"
        id = 0
    }
    skip_ipv6 = true
    # Disque
    # Spécifier taille + stockage pour que Terraform sache où mettre le clone
    disk {
        slot = "scsi0"
        size = "25"
        type = "disk"
        storage = "local-lvm"
    }
    vga {
        type = "std"
    }
    # Ordre du boot
    boot = "order=scsi0;net0"

    # cloud-init
    ipconfig0 = "ip=dhcp"

    # Configuration SSH
    sshkeys = trimspace(var.ssh_rsa_key)
}

# VM Bastion
resource "proxmox_vm_qemu" "vm_bastion" {
    # Nom de la VM
    name = "01-SRV-BAST-TRIX" # A personnaliser
    vmid = 203
    target_node = "proxmox"
    
    # Nom du template exact du template Proxmox
    clone = "debian-13.3.0-cloud-template" # A personnaliser

    # Type de clone (full#linked)
    full_clone= true

    # Configuration système (DOIT être cohérent avec template)
    agent = 1
    os_type = "cloud-init"

    # Création du compte local
    ciuser = "cloudadm"
    cipassword = var.cloudadm_password
    cicustom = "user=local:snippets/user_data_trix.yml"

    # Ressources (Possibilité de surcharger les valeurs du template ici)
    cpu {
        type = "host"
        cores = 1
        sockets = 1
    }
    memory = 2048

    # Réseau
    network {
        model = "virtio"
        bridge = "vmbr0"
        id = 0
    }
    skip_ipv6 = true
    # Disque
    # Spécifier taille + stockage pour que Terraform sache où mettre le clone
    disk {
        slot = "scsi0"
        size = "25"
        type = "disk"
        storage = "local-lvm"
    }
    vga {
        type = "std"
    }
    # Ordre du boot
    boot = "order=scsi0;net0"

    # cloud-init
    ipconfig0 = "ip=dhcp"

    # Configuration SSH
    sshkeys = trimspace(var.ssh_rsa_key)
}