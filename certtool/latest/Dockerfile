FROM ubuntu:18.04

MAINTAINER Steven Pojer<steven.pojer@gmail.com>

RUN apt-get update && \
    apt-get install -y \
        gnutls-bin \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /data
WORKDIR /data

ENTRYPOINT ["certtool"]
