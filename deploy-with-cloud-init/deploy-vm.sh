#!/bin/bash
export $(grep -v '^#' .env | xargs)

# Clone the template into a new VM
qm clone $TEMPLATE_ID $VMID --name $NAME --full true

# Resize the primary boot disk (otherwise it will be around 10G by default)
qm resize $VMID scsi0 +$DISKRESIZE

# For many Cloud-Init images, it is required to configure a serial console and use it as a display. 
# If the configuration doesn’t work for a given image however, 
# switch back to the default display instead.
qm set $VMID --serial0 socket --vga serial0

# Configure the IP setup. 
qm set $VMID --ipconfig0 $IPCONFIG0

# Amount of RAM for the VM in MiB.
qm set $VMID --cores $CORES
# The number of cores per socket.
qm set $VMID --memory $MEMORY

# Create a secondary disk for /home directory
qm set $VMID --scsi1 $STORAGE:$SECONDARY_DISKSIZE

# The file needs to be located in a folder that is referred to by "local" storage. 
# It needs to be in a specific directory structure as shown here:
# https://pve.proxmox.com/wiki/Storage:_Directory
# i.e /var/lib/vz/snippets/
mkdir -p /var/lib/vz/snippets

cp vm-cloud-init.yaml /var/lib/vz/snippets/vm-$VMID-cloud-init.yaml
qm set $VMID --cicustom user=local:snippets/vm-$VMID-cloud-init.yaml

# One way to check if the file is run is to start terminal immediately after VM start
qm start $VMID && qm terminal $VMID
