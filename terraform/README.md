# Terraform

**Etat actuel :** Actuellement, le terraform est écrit de sorte à créer une VM "Hello World" de Test

**A Savoir:** Il sera nécessaire de créer un `terraform.tfvars` qui contiendra vos variables. De plus certaines variables du `main.tf` peuvent changer en fonction de votre version de `telmate` (Provider Proxmox) et/ou du matériel utilisé.

## Provisionnement (Cloud-init)

- Activation des `Snippets` sur Proxmox : `Datacenter > Storage > local > Edit` et ajouter `Snippets`

- Upload du fichier de configuration
    - Se connecter en SSH sur le Proxmox
    - Création du dossier `snippets`
        ``` bash
            mkdir -p /var/lib/vz/snippets
        ```
    - Puis copier le fichier qui se trouve dans `ressources`
        ```bash
            scp user_data.cfg root@XX.XX.XX.XX:/var/lib/vz/snippets/user_data_trix.yml
        ```
