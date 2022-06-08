#!/bin/bash

cd /minecraft

echo "eula=$EULA" > eula.txt

echo "allow-flight=${allow_flight}" > server.properties
echo "allow-nether=${allow_nether}" >> server.properties
echo "broadcast-console-to-ops=${broadcast_console_to_ops}" >> server.properties
echo "broadcast-rcon-to-ops=${broadcast_rcon_to_ops}" >> server.properties
echo "difficulty=${difficulty}" >> server.properties
echo "enable-command-block=${enable_command_block}" >> server.properties
echo "enable-jmx-monitoring=${enable_jmx_monitoring}" >> server.properties
echo "enable-query=${enable_query}" >> server.properties
echo "enable-rcon=${enable_rcon}" >> server.properties
echo "enable-status=${enable_status}" >> server.properties
echo "enforce-whitelist=${enforce_whitelist}" >> server.properties
echo "entity-broadcast-range-percentage=${entity_broadcast_range_percentage}" >> server.properties
echo "force-gamemode=${force_gamemode}" >> server.properties
echo "function-permission-level=${function_permission-level}" >> server.properties
echo "gamemode=${gamemode}" >> server.properties
echo "generate-structures=${generate_structures}" >> server.properties
echo "generator-settings=${generator_settings}" >> server.properties
echo "hardcore=${hardcore}" >> server.properties
echo "hide-online-players=${hide_online_players}" >> server.properties
echo "level-name=${level_name}" >> server.properties
echo "level-seed=${level_seed}" >> server.properties
echo "level-type=${level_type}" >> server.properties
echo "max-players=${max_players}" >> server.properties
echo "max-tick-time=${max_tick_time}" >> server.properties
echo "max-world-size=${max_world_size}" >> server.properties
echo "motd=${motd}" >> server.properties
echo "network-compression-threshold=${network_compression_threshold}" >> server.properties
echo "online-mode=${online_mode}" >> server.properties
echo "op-permission-level=${op_permission_level}" >> server.properties
echo "player-idle-timeout=${player_idle_timeout}" >> server.properties
echo "prevent-proxy-connections=${prevent_proxy_connections}" >> server.properties
echo "pvp=${pvp}" >> server.properties
echo "query.port=${query_port}" >> server.properties
echo "rate-limit=${rate_limit}" >> server.properties
echo "rcon.password=${rcon_password}" >> server.properties
echo "rcon.port=${rcon_port}" >> server.properties
echo "require-resource-pack=${require_resource_pack}" >> server.properties
echo "resource-pack=${resource_pack}" >> server.properties
echo "resource-pack-prompt=${resource_pack_prompt}" >> server.properties
echo "resource-pack-sha1=${resource_pack_sha1}" >> server.properties
echo "server-ip=${server_ip}" >> server.properties
echo "server-port=${server_port}" >> server.properties
echo "simulation-distance=${simulation_distance}" >> server.properties
echo "spawn-animals=${spawn_animals}" >> server.properties
echo "spawn-monsters=${spawn_monsters}" >> server.properties
echo "spawn-npcs=${spawn_npcs}" >> server.properties
echo "spawn-protection=${spawn_protection}" >> server.properties
echo "sync-chunk-writes=${sync_chunk-writes}" >> server.properties
echo "text-filtering-config=${text_filtering_config}" >> server.properties
echo "use-native-transport=${use_native_transport}" >> server.properties
echo "view-distance=${view_distance}" >> server.properties
echo "white-list=${white_list}" >> server.properties

{
  while true
  do
    echo "Starting restart timer (${RESTART_INTERVAL} seconds)"
    sleep ${RESTART_INTERVAL}
    echo "Initiating restart..."
    /root/mcrcon -P ${rcon_port} -p ${rcon_password} -w 10 \
      list \
      "tellraw @a {\"text\":\"Server will restart in 1 minute...\",\"color\":\"red\"}" \
      list \
      list \
      "tellraw @a {\"text\":\"Server will restart in 30 seconds...\",\"color\":\"red\"}" \
      list \
      "tellraw @a {\"text\":\"Server will restart in 10 seconds...\",\"color\":\"red\"}" \
      stop
  done
} &

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
