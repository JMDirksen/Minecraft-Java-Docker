#!/bin/bash

sleep 1.5m

while [ -n "$DEPLOYMENTID" ]; do
  limit=$((60 / 5 * 24 * 30))
  online=$(find server/world/stats -mmin -5 -type f | wc -l)
  dt=$(date +"%Y-%m-%d+%H:%M")
  uri="https://script.google.com/macros/s/$DEPLOYMENTID/exec?stats=$dt;$online&limit=$limit"
  echo "Players online: $online"
  curl --no-progress-meter "$uri" -o /dev/null
  sleep 300
done
