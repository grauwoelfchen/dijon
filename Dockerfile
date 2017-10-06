FROM debian:jessie
MAINTAINER Yasuhiro Asaka <yasuhiro.asaka@grauwoelfchen.net>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "» prepare /jitsi-meet"\
 && mkdir -p /jitsi-meet\
 && echo "» install packages"\
 && apt-get update\
 && apt-get install -qy\
 curl\
 dnsutils\
 apt-transport-https\
 ca-certificates\
 && echo "deb https://download.jitsi.org stable/" >>\
 /etc/apt/sources.list.d/jitsi-stable.list\
 && echo "» download jitsi gpg key"\
 && curl -L https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -\
 && echo "» install jitsi-meet"\
 && apt-get update\
 && apt-get install -y jitsi-meet\
 && echo "» clean up"\
 && apt-get clean

ADD ./data /jitsi-meet/data

COPY files/jitsi/meet/config.js /etc/jitsi/meet/config.js
COPY files/jitsi/jicofo/config /etc/jitsi/jicofo/config
COPY files/jitsi/videobridge/config /etc/jitsi/videobridge/config
COPY files/jitsi/videobridge/sip-communicator.properties /etc/jitsi/videobridge/sip-communicator.properties

COPY files/localhost.cfg.lua /etc/prosody/conf.d/localhost.cfg.lua

COPY files/nginx.conf /etc/nginx/sites-available/jitsi-meet
RUN cd /etc/nginx/sites-enabled\
 && rm default\
 && rm localhost.conf\
 && ln -s ../sites-available/jitsi-meet jitsi-meet

EXPOSE 80 443 4443 10000-10004/udp

COPY files/users.csv /jitsi-meet/users.csv
COPY register-users.sh /jitsi-meet/register-users.sh
RUN chmod +x /jitsi-meet/register-users.sh && /jitsi-meet/register-users.sh

COPY run.sh /jitsi-meet/run.sh
CMD chmod +x /jitsi-meet/run.sh && /jitsi-meet/run.sh
