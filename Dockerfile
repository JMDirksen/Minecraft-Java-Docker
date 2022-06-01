FROM ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openjdk-18-jre-headless curl jq
WORKDIR /minecraft
COPY ./run.sh ./
VOLUME /minecraft

# Set the java -Xms and -Xmx parameters
ENV MEMORY=6G
# Set following to TRUE from run command indicating your agreement to the EULA (https://account.mojang.com/documents/minecraft_eula).
ENV EULA=false

ENTRYPOINT [ "/bin/bash", "run.sh" ]
