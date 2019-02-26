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



# Install resources for the app
docker pull mysql

# Show the images
docker images



docker exec -it mysql bash


docker create -v $(pwd)/database --name data_for_mysql mysql /bin/true

docker run --name ecommerce-mysql -e MYSQL_ROOT_PASSWORD=123456789 -d mysql:tag

#docker run --name some-app --link ecommerce-mysql:mysql -d application-that-uses-mysql

docker run -it --link ecommerce-mysql:mysql --rm mysql sh -c 'exec mysql -h"http://localhost" -P"3306" -uroot -p"123456789"'
# docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p
