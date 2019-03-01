#!/bin/bash -xve

PROJECT=python_ecommerce
LABEL=dev


APP=database
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}
#docker exec -it python_ecommerce_database_dev bash
#ALTER USER dev_user IDENTIFIED WITH mysql_native_password BY '111';

APP=phpmyadmin
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


APP=web
./docker_create_container.sh -n ${PROJECT} -z ${LABEL} -a ${APP}


#clr && docker service rm $(docker service ls -q) && docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)
#clr && docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)
#docker stack deploy -c ./docker-compose-dev.yml hola

docker-compose -f ./docker-compose-dev.yml up
