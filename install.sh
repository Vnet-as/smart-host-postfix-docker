#!/bin/bash

# Supervisord configuration
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:postfix]
command=/opt/postfix.sh

[program:syslog-ng]
command=/opt/syslog.sh
EOF

# Script for running postfix on startup
cat > /opt/postfix.sh <<EOF
#!/bin/bash
/usr/sbin/postfix -c /etc/postfix start
tail -f /var/log/mail.log
EOF
chmod +x /opt/postfix.sh

# Script for running syslog process
cat > /opt/syslog.sh <<EOF
#!/bin/bash
syslog-ng --no-caps --process-mode foreground
EOF
chmod +x /opt/syslog.sh

# Postfix smart-host configuration
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

