#!/bin/bash
export $(grep -v '^#' .env | xargs)

# Declare an associative array
declare -A templates
declare -A hosts

templates["pve2"]=$NODE2_VMID
templates["pve3"]=$NODE3_VMID

hosts["pve2"]=$NODE2_IP
hosts["pve3"]=$NODE3_IP

for node in "${!templates[@]}"; do
	for host in "${!hosts[@]}"; do
		if [[ $node == $host ]]; then
		  # Create a new virtual machine by cloning the template. 
			qm clone $TEMPLATE_ID ${templates[$node]} --name $TEMPLATE_NAME --target $node --full
			# Convert the VM into a template.
			ssh root@${hosts[$host]} "qm template "${templates[$node]}
		fi
	done
done

echo "VM template clone completed successfully."