#!/bin/bash

main () {
  echo "eula=$EULA" > server/eula.txt
  echo "allow-flight=${allow_flight}" > server/server.properties
  echo "allow-nether=${allow_nether}" >> server/server.properties
  echo "broadcast-console-to-ops=${broadcast_console_to_ops}" >> server/server.properties
  echo "broadcast-rcon-to-ops=${broadcast_rcon_to_ops}" >> server/server.properties
  echo "difficulty=${difficulty}" >> server/server.properties
  echo "enable-command-block=${enable_command_block}" >> server/server.properties
  echo "enable-jmx-monitoring=${enable_jmx_monitoring}" >> server/server.properties
  echo "enable-query=${enable_query}" >> server/server.properties
  echo "enable-rcon=${enable_rcon}" >> server/server.properties
  echo "enable-status=${enable_status}" >> server/server.properties
  echo "enforce-secure-profile=${enforce_secure_profile}" >> server/server.properties
  echo "enforce-whitelist=${enforce_whitelist}" >> server/server.properties
  echo "entity-broadcast-range-percentage=${entity_broadcast_range_percentage}" >> server/server.properties
  echo "force-gamemode=${force_gamemode}" >> server/server.properties
  echo "function-permission-level=${function_permission_level}" >> server/server.properties
  echo "gamemode=${gamemode}" >> server/server.properties
  echo "generate-structures=${generate_structures}" >> server/server.properties
  echo "generator-settings=${generator_settings}" >> server/server.properties
  echo "hardcore=${hardcore}" >> server/server.properties
  echo "hide-online-players=${hide_online_players}" >> server/server.properties
  echo "initial-disabled-packs=${initial_disabled_packs}" >> server/server.properties
  echo "initial-enabled-packs=${initial_enabled_packs}" >> server/server.properties
  echo "level-name=${level_name}" >> server/server.properties
  echo "level-seed=${level_seed}" >> server/server.properties
  echo "level-type=${level_type}" >> server/server.properties
  echo "log-ips=${log_ips}" >> server/server.properties
  echo "max-chained-neighbor-updates=${max_chained_neighbor_updates}" >> server/server.properties
  echo "max-players=${max_players}" >> server/server.properties
  echo "max-tick-time=${max_tick_time}" >> server/server.properties
  echo "max-world-size=${max_world_size}" >> server/server.properties
  echo "motd=${motd}" >> server/server.properties
  echo "network-compression-threshold=${network_compression_threshold}" >> server/server.properties
  echo "online-mode=${online_mode}" >> server/server.properties
  echo "op-permission-level=${op_permission_level}" >> server/server.properties
  echo "player-idle-timeout=${player_idle_timeout}" >> server/server.properties
  echo "prevent-proxy-connections=${prevent_proxy_connections}" >> server/server.properties
  echo "pvp=${pvp}" >> server/server.properties
  echo "query.port=${query_port}" >> server/server.properties
  echo "rate-limit=${rate_limit}" >> server/server.properties
  echo "rcon.password=${rcon_password}" >> server/server.properties
  echo "rcon.port=${rcon_port}" >> server/server.properties
  echo "require-resource-pack=${require_resource_pack}" >> server/server.properties
  echo "resource-pack=${resource_pack}" >> server/server.properties
  echo "resource-pack-id=${resource_pack_id}" >> server/server.properties
  echo "resource-pack-prompt=${resource_pack_prompt}" >> server/server.properties
  echo "resource-pack-sha1=${resource_pack_sha1}" >> server/server.properties
  echo "server-ip=${server_ip}" >> server/server.properties
  echo "server-port=${server_port}" >> server/server.properties
  echo "simulation-distance=${simulation_distance}" >> server/server.properties
  echo "spawn-animals=${spawn_animals}" >> server/server.properties
  echo "spawn-monsters=${spawn_monsters}" >> server/server.properties
  echo "spawn-npcs=${spawn_npcs}" >> server/server.properties
  echo "spawn-protection=${spawn_protection}" >> server/server.properties
  echo "sync-chunk-writes=${sync_chunk_writes}" >> server/server.properties
  echo "text-filtering-config=${text_filtering_config}" >> server/server.properties
  echo "use-native-transport=${use_native_transport}" >> server/server.properties
  echo "view-distance=${view_distance}" >> server/server.properties
  echo "white-list=${white_list}" >> server/server.properties

  # Get current version
  [ -f "version" -a -f "server/server.jar" ] && current_version=$(cat "version") || current_version=0
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
    echo "$latest_version" > "version"
    echo "Updated!"
  }

  # Starting server
  echo "Set memory: $MEMORY"
  echo "Starting server..."
  cd server
  java -Xms$MEMORY -Xmx$MEMORY -jar server.jar
}

main
