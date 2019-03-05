# FROM python:3-slim
FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /code

WORKDIR /code

COPY requirements.txt /code/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

COPY . /code/

RUN sed -i 's/127.0.0.1/db/g' x.py
RUN sed -i 's/127.0.0.1/db/g' api/settings.py

#CMD python manage.py migrate
#CMD python manage.py runserver 0.0.0.0:8001
