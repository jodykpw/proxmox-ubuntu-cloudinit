#!/bin/bash
export $(grep -v '^#' .env | xargs)

if [ ! -e $IMAGE_FILE ]
then
 # Download the Cloud Init Image
 wget $IMAGE_URL
fi

# Create  a virtual machine.
qm create $VMID --name $NAME --memory $MEMORY --net0 virtio,bridge=vmbr0 --cores $CORES --sockets $SOCKETS --cpu cputype=$CPUTYPE --description $DESCRIPTION

# Update the virtual machine options
qm set $VMID --ostype $OSTYPE

# Import an external disk image as an unused disk in a VM. The image format has to be supported by qemu-img(1).
qm importdisk $VMID $IMAGE_FILE $STORAGE

# Attaching the import disk it to a SCSI drive
if [ "$STORAGETYPE" = "nfs" ]; then
   # For file-based storages
qm set $VMID --scsihw $SCSIHW --scsi0 $STORAGE:$VMID/vm-$VMID-disk-0.raw
else
   # For local storage
   qm set $VMID --scsihw $SCSIHW --scsi0 $STORAGE:vm-$VMID-disk-0
fi

# Specify guest boot order.
qm set $VMID --boot order='scsi0'

# Add Cloud-Init CD-ROM drive
qm set $VMID --ide2 $STORAGE:cloudinit

# Convert the VM into a template.
qm template $VMID

# Clean up.
if [ "$DELETE_IMAGE" = "true" ] ; then
   # Delete Cloud Init Image
   rm $IMAGE_FILE
fi