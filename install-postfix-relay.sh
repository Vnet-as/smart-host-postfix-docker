#!/bin/bash
set -e

# Postfix smart-host configuration via environment variables
if [[ -n $USERNAME && -n $PASSWORD && -n $MYNETWORKS && -n $RELAY_HOST && -n $HOSTNAME ]]; then
    touch /etc/postfix/main.cf
    postconf -e "myhostname = $HOSTNAME"
    postconf -e "mydestination = $HOSTNAME localhost"
    postconf -e "relayhost = $RELAY_HOST"
    postconf -e "inet_protocols = all"
    postconf -e "inet_interfaces = all"
    postconf -e "smtp_sasl_auth_enable = yes"
    postconf -e "smtp_sasl_password_maps = static:$USERNAME:$PASSWORD"
    postconf -e "smtp_sasl_security_options = "
    postconf -e "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 $MYNETWORKS"
    postconf -e "smtpd_relay_restrictions = permit_mynetworks defer_unauth_destination"
fi

exec /usr/sbin/postfix -c /etc/postfix start
