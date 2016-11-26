FROM debian:jessie

RUN apt-get update ; apt-get upgrade -y

RUN apt-get install -y git nodejs curl wget build-essential python

RUN mkdir /c9 ; cd /c9 ; git clone git://github.com/c9/core.git . ; scripts/install-sdk.sh

WORKDIR /c9

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 8181
CMD ["nodejs", "server.js"]
