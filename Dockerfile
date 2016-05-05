FROM debian:latest

MAINTAINER infiniteproject@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install icecast2 && apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/etc/icecast2"]
EXPOSE 8000

COPY ./docker-entrypoint.sh /entrypoint.sh
RUN curl -o /etc/icecast2/icecast.xml https://raw.githubusercontent.com/xiph/Icecast-Server/master/conf/icecast.xml.in
RUN chmod +x /entrypoint.sh
RUN chown -R icecast2:icecast /etc/icecast2/*

USER icecast2
ENTRYPOINT ["/entrypoint.sh"]
