FROM debian:jessie

RUN apt-get update ; apt-get upgrade -y

RUN apt-get install -y libcups2 samba samba-common cups

ADD smb.conf /etc/samba/smb.conf

WORKDIR /var/project

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["supervisord"]
