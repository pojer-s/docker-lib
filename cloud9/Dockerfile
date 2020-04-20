FROM debian:9

RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      git \
      nodejs \
      python \
      wget \
      locales \
    && \
    rm -rf /var/lib/apt/lists/*

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    locale-gen en_US.UTF-8

RUN mkdir /c9 && \
    cd /c9 && \
    git clone git://github.com/c9/core.git . && \
    scripts/install-sdk.sh

WORKDIR /c9

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 8181
CMD ["nodejs", "server.js"]
