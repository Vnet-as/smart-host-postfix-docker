# Postfix Smart Host Docker

Smart Host (or Relay Host) is server which routes all outgoing messages to specified remote domain.
You can use it as mail server for applications which do not support SASL authentication or for other needs.

Customization of variable parameters as relay server, mail account credentials and allowed IP addresses or networks is done with docker environment variables.
Installation

## Installation

For full installation use:

```
git clone https://github.com/Vnet-as/smart-host-postfix-docker.git
cd smart-host-postfix-docker
docker build -t lirt/smart-host-postfix-docker .
```

Or download docker image from dockerhub with:

```
docker pull lirt/smart-host-postfix-docker
```

## Running

Run with following environment variables:

- **HOSTNAME**: hostname for this docker smart host (eg. server.example.com)
- **RELAY_HOST**: mail server where we need to authenticate user account (eg. mail.example.com)
- **USERNAME**: account username to log to (eg. user@example.com)
- **PASSWORD**: account password (eg. abcd1234)
- **MYNETWORKS**: Networks which are allowed to send mail through this smart-host (eg. "172.20.100.0/24 172.20.101.12 172.20.101.13")

## Example run

```
docker run \
   -h smarthost.example.com \
   -e HOSTNAME=smarthost.example.com \
   -e RELAY_HOST=mail.example.com \
   -e USERNAME=relay-acc@example.com \
   -e PASSWORD=abcd1234 \
   -e MYNETWORKS="172.20.100.0/24 172.20.101.12 172.20.101.13" \
   -d lirt/smart-host-postfix-docker
```
