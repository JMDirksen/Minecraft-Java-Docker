FROM ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openjdk-17-jre-headless
WORKDIR /root
ADD https://github.com/xMamo/VanillaVotifier/releases/download/v4.2.1/VanillaVotifier.jar VanillaVotifier.jar
CMD java -jar VanillaVotifier.jar
