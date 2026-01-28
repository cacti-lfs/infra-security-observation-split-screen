# Ansible

Pour une meilleure isolation des environnements, il est recommandé de créer des environnements virtualisés python et d'utiliser le `requirements.txt` pour que les dépendances soient communes à celles du projet infra-security-observation.

## Création d'un environnement `.venv`
- Installation de python

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.12 python3.12-venv -y
```

- Création de l'environnement
```bash
/usr/bin/python3.12 -m venv ./.venv
```
- Activation de l'environnement
```bash
source .venv/bin/activate
```

- Mise à jour de pip
```bash
pip install --upgrade pip
```

- Installation des dépendances via le `requirements.txt`
```bash
pip install -r requirements.txt
```

- Modifier son fichier `activate`ou créer un `setup_env.sh` avec les credentials de Proxmox pour Ansible
Exemple type de `setup_env.sh` :
```bash
#!/bin/bash
export PROXMOX_URL="http://XX.XX.XX.XX:8006"
export PROXMOX_USER="ansible-prov@pve"
# Format attendu par le plugin : nom_utilisateur!nom_token
export PROXMOX_TOKEN_ID="ansible"
export PROXMOX_TOKEN_SECRET=""
```

## Configuration Ansible

- Création d'un role Ansible
```bash
pveum role add AnsibleProv -privs "Datastore.Allocate Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Console VM.Migrate VM.PowerMgmt SDN.Use Pool.Audit VM.GuestAgent.Audit"
```

- Création d'un utilisateur Ansible
```bash
pveum user add ansible-prov@pve --password <password>
```

- Attribution d'u rôle Ansible à l'utilisateur
```bash
pveum user add ansible-prov@pve --password <password>
```

- Création d'un token
```bash
pveum user token add ansible-prov@pve ansible -expire 0 -privsep 0 -comment "Ansible token"
```

## Plugins pour l'inventaire

- Installation du plugin Proxmox
```bash
ansible-galaxy collection install git+https://github.com/ansible-collections/community.proxmox.git
```

- Installation plugin grafana
```
ansible-galaxy collection install community.grafana --force
```