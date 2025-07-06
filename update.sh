#!/bin/bash

main() {
  echo "Updater started."

  sleep 1m

  while true; do

    echo -n "Checking for update... "

    # Get current version
    [ -f "server/version" -a -f "server/server.jar" ] && current_version=$(cat "server/version") || current_version=0

    # Get latest version
    manifest_url="https://launchermeta.mojang.com/mc/game/version_manifest.json"
    latest_version=$(curl -s "$manifest_url" | jq -r ".latest.release")

    # Stop if not up-to-date
    [ $current_version != $latest_version ] && stop_server || echo "No update."

    sleep 1h

  done
}

stop_server() {
  echo "New update available!"
  echo "Stopping server for update..."
  screen -S mc -X stuff "tellraw @a {\"text\":\"Restarting in 30 sec...\",\"color\":\"red\"}\n"
  sleep 20
  screen -S mc -X stuff "tellraw @a {\"text\":\"Restarting in 10 sec...\",\"color\":\"red\"}\n"
  sleep 5
  screen -S mc -X stuff "tellraw @a {\"text\":\"Restarting in 5 sec...\",\"color\":\"red\"}\n"
  sleep 5
  screen -S mc -X stuff "stop\n"
}

main
