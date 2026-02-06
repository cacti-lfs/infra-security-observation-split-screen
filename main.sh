#!/bin/bash

echo -e "################################"
echo -e "## Déploiement Infrastructure ##"
echo -e "################################"

# TERRAFORM
echo -e "\n --- [ETAPE 1] Création des VMs avec Terraform ---"
cd ./terraform || exit
terraform init
terraform apply -auto-approve

if [ $? -aq 0 ];then
    echo -e "Infrastructure créée avec succès."
else
    echo -e " Erreur lors du terraform applu. Arrêt du déploiement"
    exit 1
fi

# Pause 30s
echo -e "\n --- Attente pour l'initialisation réseau (30s) ..."
sleep 30

# ANSIBLE
echo -e "\n --- [ETAPE 2] Configuration logicielle avec Ansible"
cd ..
ansible-playbook -i ansible/inventory/inventory.proxmox.yml ansible/main.yml \
    --vault-password-file ansible/sup/vars/.vault_password
if [$? -eq 0 ]; then
    echo -e "Déploiement et configuration terminés !"
else
    echo -e "Erreur lors du playbook Ansible."
    exit 1
fi