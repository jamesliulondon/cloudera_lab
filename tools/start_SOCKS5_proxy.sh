#!/bin/bash

PID="`/usr/bin/pgrep -f '\<[s]sh .*-D 80'`"
if [ -n "$PID" ]
then
  echo 'Aborting - one or more SOCKS5 proxies are already running.'
  echo 'Process ID(s):' $PID'.'
  exit 1
else
  echo -e "\n$HOSTNAME Running ${0##*/}."
  sudo ssh -p 443 -D 80 -g training@elephant
  echo -e "\n$HOSTNAME ${0##*/} done."
fi