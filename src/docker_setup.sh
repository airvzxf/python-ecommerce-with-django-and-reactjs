#!/bin/bash -vxe

# Install docker in ArchLinux.
#pacman -S docker

# Check if docker daemon is running?
sudo systemctl status docker

# Docker is owned by root, we need to add to our user.
ls -la /var/run/docker.sock

# Create the group.
sudo groupadd docker

# Add docker group to your user.
sudo usermod -aG docker ${USER}

# Show the groups and it should has docker.
groups

# Start the docker daeomn every time your machine startups.
sudo systemctl enable docker

# Restart your computer
# TODO: Add input to ask if you want to reboot your computer.
read -n 1 -r -p "It needs to reboot your machine, Do you accept to reboot? [y/N]: " DOES_IT_REBOOT

if ! [[ ${DOES_IT_REBOOT} =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	echo -e "\nTRebooting... It will take some time."
	reboot --reboot
	exit -1
fi
