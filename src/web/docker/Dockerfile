FROM node:19.7-bullseye-slim

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY . /usr/src/app

CMD ["npm", "start"]
