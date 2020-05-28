FROM alpine

RUN apk add --update nodejs npm

WORKDIR /usr/src/app

ADD index.js .

EXPOSE 3000

CMD [ "node", "index.js" ]
