# Postfix Smart Host Docker

[![Docker pulls](https://img.shields.io/docker/pulls/lirt/smart-host-postfix-docker.svg)](https://hub.docker.com/r/lirt/smart-host-postfix-docker)
[![Docker automated build](https://img.shields.io/docker/automated/lirt/smart-host-postfix-docker.svg)](https://hub.docker.com/r/lirt/smart-host-postfix-docker)

Smart Host (or Relay Host) is a server which routes all outgoing messages to specified remote domain. You can use it as a mail server for applications which do not support SASL authentication or for other needs.

Customization of variable parameters such as relay server, mail account credentials and allowed IP addresses or networks is done using docker environment variables or configuration file.

## Installation

For full installation use:

```bash
git clone https://github.com/Vnet-as/smart-host-postfix-docker.git
cd smart-host-postfix-docker
docker build -t lirt/smart-host-postfix-docker-local .
```

Or download docker image from DockerHub with command:

```bash
docker pull lirt/smart-host-postfix-docker
```

## Docker environment variables

You can run smart host with following docker environment variables (note that all environment variables are mandatory):

- **HOSTNAME**: hostname for this docker smart host (eg. server.example.com)
- **RELAY_HOST**: mail server where we need to authenticate user account (eg. mail.example.com)
- **USERNAME**: account username to log to (eg. user@example.com)
- **PASSWORD**: account password (eg. abcd1234)
- **MYNETWORKS**: Networks which are allowed to send mail through this smart-host (eg. "172.20.100.0/24 172.20.101.12 172.20.101.13")

## Example run

Example run with environment variables:

```bash
docker run \
    -h smarthost.example.com \
    -e HOSTNAME=smarthost.example.com \
    -e RELAY_HOST=mail.example.com \
    -e USERNAME=relay-acc@example.com \
    -e PASSWORD=abcd1234 \
    -e MYNETWORKS="172.20.100.0/24 172.20.101.12 172.20.101.13" \
    -d lirt/smart-host-postfix-docker
```

For using custom postfix configuration mounted with docker volume there is directory `postfix` with sample configuration files. Example run with configuration files mounted as docker volume:

```bash
docker run \
    -v <ABS_PATH_TO_POSTFIX_CF_DIR>:/etc/postfix \
    -d lirt/smart-host-postfix-docker
```
