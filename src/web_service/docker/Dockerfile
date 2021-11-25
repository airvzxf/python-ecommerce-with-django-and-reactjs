# FROM python:3-slim
FROM python:3.10.0b2

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . /usr/src/app/

CMD ./run.sh "${HOST}" "${PORT}" "${DB_HOST}" "${DB_PORT}"
