# docker-syncthing [![Docker Pulls](https://img.shields.io/docker/pulls/msis/armhf-syncthing.svg)](https://registry.hub.docker.com/u/msis/armhf-syncthing/)

Run syncthing from a docker container on an ARMv7 (armhf)

## Install
```sh
docker pull msis/armhf-syncthing
```

## Usage

```sh
docker run -d --restart=always \
  -v /srv/sync:/srv/data \
  -v /srv/syncthing:/srv/config \
  -p 22000:22000  -p 21025:21025/udp -p 8080:8080 \
  --name syncthing \
  msis/armhf-syncthing
```

If you want to add a new folder, make sure you set the path to something in `/srv/data`.

**NOTE**: for security reasons, starting this docker container will change the permissions of all files in your data directory to a new, docker-only user. This ensures that the docker container can access the files.

