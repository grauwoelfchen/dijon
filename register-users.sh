#!/bin/bash
set -x

cat /jitsi-meet/users.csv | while IFS=","; read -r n d p; do
prosodyctl register $n $d $p
done
