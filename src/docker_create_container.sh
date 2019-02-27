#!/bin/bash

set +vxe

#PROJECT=python_ecommerce
#APP=app
#ENVIRONMENT=dev

usage() {
	echo "Example:"
	echo "PROJECT:      python_ecommerce"
	echo "APP:          mySql"
	echo "ENVIRONMENT:  dev"
	echo "Usage: $0 -p project_name -a app_name -e enviroment_name" 1>&2; exit -1;
}

while getopts ":p:a:e:" OPTIONS; do
	case "${OPTIONS}" in
		p)
			PROJECT=${OPTARG}
			;;
		a)
			APP=${OPTARG}
			;;
		e)
			ENVIRONMENT=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done

# Delete all the parameters except the script name.
shift $((OPTIND-1))

if [ -z "${PROJECT}" ] || [ -z "${APP}" ] || [ -z "${ENVIRONMENT}" ]; then
	usage
fi



set -vxe

DIR=./${APP}
DOCKER_PATH=${DIR}/docker

# Docker: Purging All Unused or Dangling Images, Containers, Volumes, and Networks.
#docker system prune -a

# Delete all.
#docker service rm $(docker service ls -q)
#docker network rm $(docker network ls -q -f name=python_ecommerce_app_dev_service_webnet)
#docker container stop $(docker ps -aq)
#yes | docker container prune
#docker image rm ${PROJECT}_${APP}:${ENVIRONMENT}
#yes | docker image prune

# Show the all.
docker container ls --all
docker image ls --all
docker service ls
docker network ls

# Build the image.
docker build \
	--file ${DOCKER_PATH}/Dockerfile \
	--tag ${PROJECT}_${APP}:${ENVIRONMENT} \
	${DIR}/

# Run the image to create a container.
docker run \
	--detach \
	--publish 80:80 \
	${PROJECT}_${APP}:${ENVIRONMENT}

# Deployment
docker swarm leave --force
docker swarm init
docker stack deploy -c ${DOCKER_PATH}/docker-compose.yml ${PROJECT}_${APP}_${ENVIRONMENT}_service
#docker stack rm ${PROJECT}_${APP}_${ENVIRONMENT}_service

docker stack services ${PROJECT}_${APP}_${ENVIRONMENT}_service
docker service ps ${PROJECT}_${APP}_${ENVIRONMENT}_service_web
docker container ls -q

# Show the all.
docker container ls --all
docker image ls --all
docker service ls
docker network ls

# Docker using remote repositories
#docker login
#docker tag ${PROJECT}_${APP}:${ENVIRONMENT} airvzxf/${PROJECT}_${APP}:${ENVIRONMENT}
#docker push airvzxf/${PROJECT}_${APP}:${ENVIRONMENT}

# Run the remote image to create a container
#docker run \
#	--detach \
#	--publish 80:80 \
#	airvzxf/${PROJECT}_${APP}:${ENVIRONMENT}

set +vxe
