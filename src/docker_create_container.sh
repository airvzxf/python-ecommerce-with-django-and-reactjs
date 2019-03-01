#!/bin/bash

set +vxe

usage() {
	echo "Example:"
	echo "PROJECT:      -n : python_ecommerce"
	echo "APP:          -a : mySql"
	echo "LABEL:        -z : dev"
	echo ""
	echo "Usage:"
	echo "$0 \\
	-n project_name \\
	-a app_name \\
	-z enviroment_name" 1>&2; exit -1;
}

while getopts ":n:a:z:e:p:" OPTIONS; do
	case "${OPTIONS}" in
		n)
			PROJECT=${OPTARG}
			;;
		a)
			APP=${OPTARG}
			;;
		z)
			LABEL=${OPTARG}
			;;
		e)
			ENVIRONMENT_VAR=${OPTARG}
			ENVIRONMENT_VARS="${ENVIRONMENT_VARS} ${ENVIRONMENT_VAR}"
			;;
		p)
			PORT=${OPTARG}
			PORTS="${PORTS} ${PORT}"
			;;
		*)
			usage
			;;
	esac
done

# Delete all the parameters except the script name.
shift $((OPTIND-1))

if [ -z "${PROJECT}" ] || [ -z "${APP}" ] || [ -z "${LABEL}" ]; then
	usage
fi



# Docker: Purging All Unused or Dangling Images, Containers, Volumes, and Networks.
#docker system prune -a

# Delete all.
#docker service rm $(docker service ls -q)
#docker network rm $(docker network ls -q -f name=python_ecommerce_app_dev_service_webnet)
#docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)
#yes | docker container prune
#docker image rm ${PROJECT}_${APP}:${LABEL}
#yes | docker image prune

# Show the all.
#docker container ls --all
#docker image ls --all
#docker service ls
#docker network ls

set -vxe

DIR=./${APP}
DOCKER_PATH=${DIR}/docker

# Build the image.
docker build \
	--file ${DOCKER_PATH}/Dockerfile \
	--tag ${PROJECT}_${APP}:${LABEL} \
	${DIR}/

set +vxe

# Run the image to create a container.
#docker run \
#	--detach \
#	--name ${PROJECT}_${APP}_${LABEL} \
#	$(
#		for ENVIRONMENT_VAR in $ENVIRONMENT_VARS; do
#			echo "--env ${ENVIRONMENT_VAR} "
#		done   
#	) \
#	$(
#		for PORT in $PORTS; do
#			echo "--publish ${PORT} "
#		done   
#	) \
#	${PROJECT}_${APP}:${LABEL}

# Deployment
#docker swarm leave --force
#docker swarm init
#docker stack deploy -c ${DOCKER_PATH}/docker-compose.yml ${PROJECT}_${APP}_${LABEL}_service
#docker stack rm ${PROJECT}_${APP}_${LABEL}_service

#docker stack services ${PROJECT}_${APP}_${LABEL}_service
#docker service ps ${PROJECT}_${APP}_${LABEL}_service_web

# Show the all.
#docker container ls --all
#docker image ls --all
#docker service ls
#docker network ls

# Docker using remote repositories
#docker login
#docker tag ${PROJECT}_${APP}:${LABEL} airvzxf/${PROJECT}_${APP}:${LABEL}
#docker push airvzxf/${PROJECT}_${APP}:${LABEL}

# Run the remote image to create a container
#docker run \
#	--detach \
#	--publish 80:80 \
#	airvzxf/${PROJECT}_${APP}:${LABEL}
