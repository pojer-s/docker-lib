FROM python:2.7

MAINTAINER Steven Pojer<steven.pojer@gmail.com>

RUN apt-get update && \
    apt-get install -y \
        python-glanceclient \
        python-novaclient \
        python-swiftclient \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /project
WORKDIR /project
