# FROM python:3-slim
FROM python:3.12.0a5-slim

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . /usr/src/app/

CMD ./run.sh "${HOST}" "${PORT}" "${DB_HOST}" "${DB_PORT}"
