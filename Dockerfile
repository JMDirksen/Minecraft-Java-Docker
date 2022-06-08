FROM ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openjdk-18-jre-headless curl jq
WORKDIR /root
COPY ./run.sh ./
ADD https://github.com/Tiiffi/mcrcon/releases/download/v0.7.2/mcrcon-0.7.2-linux-x86-64.tar.gz ./mcrcon.tar.gz
RUN tar -zxf mcrcon.tar.gz && rm mcrcon.tar.gz
VOLUME /minecraft

# Set the java -Xms and -Xmx parameters
ENV MEMORY=4G

# Set following to TRUE from run command indicating your agreement to the EULA (https://account.mojang.com/documents/minecraft_eula).
ENV EULA=false

# Interval in seconds for restarting the minecraft server
ENV RESTART_INTERVAL=36000

# server.properties settings
ENV allow_flight=false
ENV allow_nether=true
ENV broadcast_console_to_ops=true
ENV broadcast_rcon_to_ops=true
ENV difficulty=easy
ENV enable_command_block=false
ENV enable_jmx_monitoring=false
ENV enable_query=false
ENV enable_rcon=true
ENV enable_status=true
ENV enforce_whitelist=false
ENV entity_broadcast_range_percentage=100
ENV force_gamemode=false
ENV function_permission_level=2
ENV gamemode=survival
ENV generate_structures=true
ENV generator_settings={}
ENV hardcore=false
ENV hide_online_players=false
ENV level_name=world
ENV level_seed=
ENV level_type=default
ENV max_players=20
ENV max_tick_time=60000
ENV max_world_size=29999984
ENV motd="A Minecraft Server"
ENV network_compression_threshold=256
ENV online_mode=true
ENV op_permission_level=4
ENV player_idle_timeout=0
ENV prevent_proxy_connections=false
ENV pvp=true
ENV query_port=25565
ENV rate_limit=0
ENV rcon_password=password
ENV rcon_port=25575
ENV require_resource_pack=false
ENV resource_pack=
ENV resource_pack_prompt=
ENV resource_pack_sha1=
ENV server_ip=
ENV server_port=25565
ENV simulation_distance=10
ENV spawn_animals=true
ENV spawn_monsters=true
ENV spawn_npcs=true
ENV spawn_protection=16
ENV sync_chunk_writes=true
ENV text_filtering_config=
ENV use_native_transport=true
ENV view_distance=10
ENV white_list=false

CMD /bin/bash run.sh
