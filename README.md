proxmox-cloud-init
=========
This role configures and sets up three ubuntu templates on the proxmox server. The templates are used to create new VMs with cloud-init support.

Requirements
------------

This role was tested on proxmox 8.0. It should work as well on proxmox 7.0 but it was not tested.

Role Variables
--------------

```yaml
# vars file
isopath: /var/isos # path to where the images will be downloaded to on your proxmox host.
templateMemory: 2048 # memory in MB
templateCores: 2 # number of cores
templateDiskSize: 32G # disk size in GB
# starting ID for the VMs, the first VM will have the ID 8000, the second 8001 and so on.
# if you already have vms with the ID it will automatically increment the ID to the next available one.
templateStartingID: 8000
importStorage: local-lvm # the storage where the templates will be imported to.

# list of cloud images to download and import
# the template name will be the name of the proxmox template
# the additionalDescription will be added to the description of the proxmox template.
cloudimgs:
  - url: https://cloud-images.ubuntu.com/releases/20.04/release/ubuntu-20.04-server-cloudimg-amd64.img
    templateName: ubuntu-20.04-server
    additionalDescription: ""
  - url: https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img
    templateName: ubuntu-22.04-server
  - url: https://cloud-images.ubuntu.com/releases/23.04/release/ubuntu-23.04-server-cloudimg-amd64.img
    templateName: ubuntu-23.04-server
ciuser: # the user that will be added via cloudinit configurations
ipconfig0: ip=dhcp # ip6=auto,ip=dhcp 
sshkey: "" # ssh key that will be added to the user, this should be your public key.
installAgent: true # if true the proxmox agent will be installed on the VMs
```

Dependencies
------------
none

Example Playbook
----------------

Since we are using git ignore to remove any potential sshkeys from the repo, you will need to create your own version of the vars/main.yml file. You can do this by copying the vars/main.yml.example file to vars/main.yml and then editing the file to your needs.

Once you have the vars file saved you will be able to run the playbook. The playbook will prompt you for the remote password for the proxmox host. This is the password for the root user on the proxmox host.

```yaml
- name: proxmox_cloudinit.yml
  hosts: proxmox-01.home.local
  gather_facts: true
  vars_prompt: 
  - name: "ansible_password"
    prompt: "Enter the remote password"
    private: yes
  vars: 
    ansible_user: root
  tasks:
  - import_role: 
      name: proxmox/cloud-init
```
Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
