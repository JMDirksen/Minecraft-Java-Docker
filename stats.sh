#!/bin/bash

sleep 60

while [ -n "$DEPLOYMENTID" ]; do
  limit=$((60 / 5 * 24 * 30))
  online=$(find server/world/stats -mmin -5 -type f | wc -l)
  dt=$(TZ=Europe/Amsterdam date +"%Y-%m-%d+%H:%M")
  uri="https://script.google.com/macros/s/$DEPLOYMENTID/exec?stats=$dt;$online&limit=$limit"
  echo "Players online: $online"
  curl --no-progress-meter "$uri" -o /dev/null
  sleep 300
done
