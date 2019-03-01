FROM python:3-slim

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 8000/tcp
