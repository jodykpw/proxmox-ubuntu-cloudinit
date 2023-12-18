# 📕 Cloud-Init Automation Script for Ubuntu Noble N on Proxmox

This repository contains an automation script and templates for deploying Noble N instances on Proxmox using Cloud-Init. By utilising Cloud-Init in Proxmox, you can automate and customize the initial configuration of your virtual machines, making it easier to deploy and manage them at scale.

## 🚀 Deployment Steps

1. First login to your Proxmox VE host terminal:
2. `git` this repository.
3. Go to the cloned folder.

### Preparing Cloud-Init Templates

1. Go to preparing-cloud-init-template folder.
2. Modify the `preparing-cloud-init-template` environment variables in the .env file according to your requirements.

```console
chmod +x create-template.sh
./create-template.sh
```

### Deploy DevBox with Cloud Init 

1. Go to deploy-with-cloud-init folder.
2. Modify the `deploy-with-cloud-init` environment variables in the .env file according to your requirements.
3. Modify the `vm-cloud-init.yaml` file according to your requirements.

```console
chmod +x deploy-vm.sh
./deploy-vm.sh
```

### Cloning Template VMs for Scalable Deployment

To deploy a virtual machine (VM) across multiple nodes using Terraform with the Proxmox provider where each node requires its own VM template.  To clone a Proxmox template across multiple nodes, you can use a Bash script "cloning-template".  

It is important to note that this process requires shared storage, the template's disks must be stored on the shared storage to ensure proper functionality and access across the multiple nodes.

1. Go to cloning-template folder.
2. Modify the `cloning-template` clone.sh file according to your requirements.
2. Modify the `cloning-template` environment variables in the .env file according to your requirements.

```console
chmod +x clone.sh
./clone.sh
```

## 🔨🔧 Customization
Feel free to modify the deployment script and Cloud-Init template to suit your specific requirements. You can add additional configurations, modify network settings, or adjust any other parameters as needed.

## 🔎 Troubleshooting
If you encounter any issues during the deployment process or while configuring the Cloud-Init template, refer to the Proxmox and Cloud-Init documentation for troubleshooting guidance. You can also check the Proxmox host's log files for any relevant error messages.

## ❗ Disclaimer
This automation script and template are provided as-is and without warranty. Use them at your own risk. Make sure to thoroughly test the deployment in a non-production environment before deploying to production.

## 📄 License

MIT / BSD

## 🇬🇧🇭🇰 Author Information

* Author: Jody WAN
* Linkedin: https://www.linkedin.com/in/jodywan/
* Website: https://www.jodywan.com

😊 Enjoy automating your Ubuntu Noble N deployments with Cloud-Init on Proxmox!

