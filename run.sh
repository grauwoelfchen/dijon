#!/bin/sh
set -x

service prosody start
service jitsi-videobridge start
service jicofo start

service nginx start

tail -f /var/log/prosody/prosody.log
