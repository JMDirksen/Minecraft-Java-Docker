#!/bin/bash

sleep 1.5m

first_run=true
while [ -n "$WEBSTORE" ]; do
  [ -f "server/webstorekey" ] && webstorekey=$(cat "server/webstorekey") \
    || webstorekey=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 15); echo "$webstorekey" > "server/webstorekey"
  limit=$((60 / 5 * 24 * 30))
  online=$(find server/world/stats -mmin -5 -type f | wc -l)
  dt=$(date +"%Y-%m-%d %H:%M")
  uri="$WEBSTORE"
  echo "Players online: $online"
  curl --no-progress-meter -d "$dt,$online" "$uri/$webstorekey?maxlines=$limit" -o "server/webstore"
  [ $first_run = true ] && echo "Webstore: $(cat server/webstore)"
  first_run=false
  sleep 300
done
