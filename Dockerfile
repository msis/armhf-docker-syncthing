FROM multiarch/ubuntu-core:armhf-wily
MAINTAINER Mohamed Saad IBN SEDDIK <ms.ibnseddik@gmail.com> (@msibnseddik)

RUN apt-get update \
  && apt-get upgrade -y --no-install-recommends \
  && apt-get install curl ca-certificates -y --no-install-recommends \
  && apt-get autoremove -y \
  && apt-get clean

# grab gosu for easy step-down from root
RUN gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -L "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

# get syncthing
WORKDIR /srv
RUN useradd --no-create-home -g users syncthing
RUN export version=0.12.10 \ 
  && curl -L -o syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$version/syncthing-linux-arm-v$version.tar.gz \
  && tar -xzvf syncthing.tar.gz \
  && rm -f syncthing.tar.gz \
  && mv syncthing-linux-arm-v* syncthing \
  && rm -rf syncthing/etc \
  && rm -rf syncthing/*.pdf \
  && mkdir -p /srv/config \
  && mkdir -p /srv/data \

VOLUME ["/srv/data", "/srv/config"]

ADD ./start.sh /srv/start.sh
RUN chmod 770 /srv/start.sh

ENV UID=1027

ENTRYPOINT ["/srv/start.sh"]

