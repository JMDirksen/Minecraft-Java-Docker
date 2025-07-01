FROM ubuntu
RUN apt-get update && apt-get install -y openjdk-21-jre-headless curl jq
EXPOSE 25565
VOLUME /data/server
WORKDIR /data
COPY run.sh .

# Set the java -Xms and -Xmx parameters
ENV MEMORY=4G

# Set following to TRUE from run command indicating your agreement to the EULA (https://account.mojang.com/documents/minecraft_eula).
ENV EULA=false

# server.properties settings
ENV level_seed=

CMD ["/bin/bash", "run.sh"]
