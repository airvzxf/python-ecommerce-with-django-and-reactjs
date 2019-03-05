#!/bin/bash -xve

#clr && docker service rm $(docker service ls -q) && docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)
#clr && docker container stop $(docker ps -aq) && docker container rm $(docker ps -aq)
#docker stack deploy -c ./docker-compose-dev.yml python_ecommerce_stack
#docker stack rm python_ecommerce_stack

./build.sh

#docker swarm init
docker-compose -f ./docker-compose-dev.yml up



#docker pull python:3-slim
#docker pull python:3-stretch
#docker pull python:3-alpine

#docker run -it python:3-slim     python --version
#docker run -it python:3-stretch  python --version
#docker run -it python:3-alpine   python --version

#BENCHMARK="import timeit; print(timeit.timeit('import json;', number=5000))"
#docker run python:3-alpine   python -c "$BENCHMARK"
#docker run python:3-slim     python -c "$BENCHMARK"
#docker run python:3-stretch  python -c "$BENCHMARK"

#BENCHMARK="import timeit; print(timeit.timeit('list(range(10000))', number=5000))"
#docker run python:3-alpine   python -c "$BENCHMARK"
#docker run python:3-slim     python -c "$BENCHMARK"
#docker run python:3-stretch  python -c "$BENCHMARK"
