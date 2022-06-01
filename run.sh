#!/bin/bash

echo "eula=$EULA" > eula.txt

while true
do

  # Get current version
  [ -f "version.txt" ] && current_version=$(cat "version.txt") || current_version=0
  echo "Current version: $current_version"

  # Get latest version
  manifest_url="https://launchermeta.mojang.com/mc/game/version_manifest.json"
  latest_version=$(curl -s "$manifest_url" | jq -r ".latest.release")
  echo "Latest version: $latest_version"

  [ $current_version != $latest_version ] && {
    # Download new version
    echo "Downloading new version..."
    version_json_url=$(curl -s "$manifest_url" | jq -r ".versions[] | select(.id==\"$latest_version\") | .url")
    server_url=$(curl -s "$version_json_url" | jq -r ".downloads.server.url")
    curl -s -o server.jar "$server_url"
    echo "$latest_version" > "version.txt"
    echo "Updated!"
  }

  # Starting server
  echo "Starting server... ($MEMORY)"
  java -Xms$MEMORY -Xmx$MEMORY -jar server.jar
  echo "Restarting in 5 seconds..."
  sleep 5
done
