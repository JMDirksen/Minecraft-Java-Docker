FROM ubuntu
RUN apt-get update && apt-get install -y openjdk-17-jre-headless dnsutils
WORKDIR /root
ADD https://github.com/xMamo/VanillaVotifier/releases/download/v4.2.1/VanillaVotifier.jar VanillaVotifier.jar
COPY ./run.sh ./
EXPOSE 8192
ENV rcon_host=server
ENV rcon_port=25575
ENV rcon_password=password
CMD /bin/bash run.sh
