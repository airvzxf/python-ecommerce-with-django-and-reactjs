#!/bin/sh -vxe

./build.sh

PROJECT_ID=python-ecommerce-airvzxf
TAG=dev

gcloud auth configure-docker

docker tag python_ecommerce_web:${TAG} gcr.io/${PROJECT_ID}/python_ecommerce_web:${TAG}
docker tag python_ecommerce_web_service:${TAG} gcr.io/${PROJECT_ID}/python_ecommerce_web_service:${TAG}
docker tag python_ecommerce_phpmyadmin:${TAG} gcr.io/${PROJECT_ID}/python_ecommerce_phpmyadmin:${TAG}
docker tag python_ecommerce_database:${TAG} gcr.io/${PROJECT_ID}/python_ecommerce_database:${TAG}

gcloud docker -- push gcr.io/${PROJECT_ID}/python_ecommerce_web:${TAG}
gcloud docker -- push gcr.io/${PROJECT_ID}/python_ecommerce_web_service:${TAG}
gcloud docker -- push gcr.io/${PROJECT_ID}/python_ecommerce_phpmyadmin:${TAG}
gcloud docker -- push gcr.io/${PROJECT_ID}/python_ecommerce_database:${TAG}

#docker run --rm -p 80:3000 gcr.io/${PROJECT_ID}/python_ecommerce_web:${TAG}
#docker run --rm -p 8000:8000 gcr.io/${PROJECT_ID}/python_ecommerce_web_service:${TAG}
#docker run --rm -p 8080:80 gcr.io/${PROJECT_ID}/python_ecommerce_phpmyadmin:${TAG}
#docker run --rm -p 3306:3306 gcr.io/${PROJECT_ID}/python_ecommerce_database:${TAG}
