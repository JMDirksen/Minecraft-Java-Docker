FROM ubuntu
RUN apt-get update && apt-get install -y openjdk-21-jre-headless curl jq
EXPOSE 25565
VOLUME /data/server
WORKDIR /data
COPY --chmod=700 run.sh .

# Set the java -Xms and -Xmx parameters
ENV MEMORY=4G

# Set following to TRUE from run command indicating your agreement to the EULA (https://account.mojang.com/documents/minecraft_eula).
ENV EULA=false

# server.properties settings
ENV allow_flight=FALSE
ENV allow_nether=TRUE
ENV broadcast_console_to_ops=TRUE
ENV broadcast_rcon_to_ops=TRUE
ENV difficulty=easy
ENV enable_command_block=FALSE
ENV enable_jmx_monitoring=FALSE
ENV enable_query=FALSE
ENV enable_rcon=TRUE
ENV enable_status=TRUE
ENV enforce_secure_profile=TRUE
ENV enforce_whitelist=FALSE
ENV entity_broadcast_range_percentage=100
ENV force_gamemode=FALSE
ENV function_permission_level=2
ENV gamemode=survival
ENV generate_structures=TRUE
ENV generator_settings={}
ENV hardcore=FALSE
ENV hide_online_players=FALSE
ENV initial_disabled_packs=
ENV initial_enabled_packs=vanilla
ENV level_name=world
ENV level_seed=
ENV level_type=default
ENV log_ips=TRUE
ENV max_chained_neighbor_updates=1000000
ENV max_players=20
ENV max_tick_time=60000
ENV max_world_size=29999984
ENV motd="A Minecraft Server"
ENV network_compression_threshold=256
ENV online_mode=TRUE
ENV op_permission_level=4
ENV player_idle_timeout=0
ENV prevent_proxy_connections=FALSE
ENV pvp=TRUE
ENV query_port=25565
ENV rate_limit=0
ENV rcon_password=password
ENV rcon_port=25575
ENV require_resource_pack=FALSE
ENV resource_pack=
ENV resource_pack_id=
ENV resource_pack_prompt=
ENV resource_pack_sha1=
ENV server_ip=
ENV server_port=25565
ENV simulation_distance=10
ENV spawn_animals=TRUE
ENV spawn_monsters=TRUE
ENV spawn_npcs=TRUE
ENV spawn_protection=16
ENV sync_chunk_writes=FALSE
ENV text_filtering_config=
ENV use_native_transport=TRUE
ENV view_distance=10
ENV white_list=FALSE

CMD ./run.sh
