#!/bin/bash

. stats.sh &

main () {
  echo "eula=$EULA" > server/eula.txt
  echo "level-seed=${level_seed}" >> server/server.properties

  # Get current version
  [ -f "server/version" -a -f "server/server.jar" ] && current_version=$(cat "server/version") || current_version=0
  echo "Current version: $current_version"

  # Get latest version
  manifest_url="https://launchermeta.mojang.com/mc/game/version_manifest.json"
  latest_version=$(curl -s "$manifest_url" | jq -r ".latest.release")
  echo "Latest version: $latest_version"

  # Download new version
  [ $current_version != $latest_version ] && {
    echo "Downloading new version..."
    version_json_url=$(curl -s "$manifest_url" | jq -r ".versions[] | select(.id==\"$latest_version\") | .url")
    server_url=$(curl -s "$version_json_url" | jq -r ".downloads.server.url")
    curl -s -o "server/server.jar" "$server_url"
    echo "$latest_version" > "server/version"
    echo "Updated!"
  }

  # Starting server
  echo "Set memory: $MEMORY"
  echo "Starting server..."
  cd server
  java -Xms$MEMORY -Xmx$MEMORY -jar server.jar
}

main
