#!/bin/bash

# TODO: Create the script folder and add scripts for install docker, add user, start docker daemon

# Install docker in ArchLinux
#pacman -S docker

# Check if docker daemon is running?
sudo systemctl status docker

# Docker is owned by root, we need to add to our user.
ls -la /var/run/docker.sock

# Create the group
sudo groupadd docker

# Add docker group to your user
sudo usermod -aG docker ${USER}

# Restart your computer
# TODO: Add input to ask if you want to reboot your computer.
#reboot --reboot

# Show the groups and it should has docker
groups

# Start the docker daeomn
sudo systemctl start docker
