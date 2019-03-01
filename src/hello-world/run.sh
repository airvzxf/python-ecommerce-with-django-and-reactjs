#!/bin/bash

#docker build --tag=friendlyhello .
#docker image ls
#docker run -p 4000:80 friendlyhello
#curl http://localhost:4000

#docker swarm init
docker stack deploy -c docker-compose.yml getstartedlab
docker service ls
docker service ps getstartedlab_web
docker container ls -q

#curl -4 http://localhost:4000
#curl -6 http://localhost:4000

sleep 5
curl -4 http://localhost:4000
for run in {1..2000}; do bash -c "curl -4 http://localhost:4000 &" > /dev/null 2>&1 ; done

#docker stack rm getstartedlab
#docker swarm leave --force
