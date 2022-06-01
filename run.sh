#!/bin/bash

echo "eula=$EULA" > eula.txt

echo "difficulty=$DIFFICULTY" > server.properties
echo "level-seed=$SEED" >> server.properties
echo "max-players=$MAX_PLAYERS" >> server.properties
echo "motd=$MOTD" >> server.properties

while true
do

  # Get current version
  [ -f "version.txt" ] && current_version=$(cat "version.txt") || current_version=0
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
    curl -s -o server.jar "$server_url"
    echo "$latest_version" > "version.txt"
    echo "Updated!"
  }

  # Starting server
  echo "Set memory: $MEMORY"
  echo "Starting server..."
  java -Xms$MEMORY -Xmx$MEMORY -jar server.jar
  echo "Restarting in 3 seconds..."
  sleep 3

done
