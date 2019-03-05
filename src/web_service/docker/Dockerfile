# FROM python:3-slim
FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . /usr/src/app/
