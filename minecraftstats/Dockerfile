FROM httpd
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git python3
RUN rm -rf /usr/local/apache2/htdocs
RUN git clone https://github.com/pdinklag/MinecraftStats.git /usr/local/apache2/htdocs
VOLUME /minecraft
WORKDIR /usr/local/apache2/htdocs
ENV SERVER=/minecraft
ENV INTERVAL=60
ENV INACTIVE_DAYS=7
ENV MIN_PLAYTIME=0
CMD (python3 makeconfig.py --server ${SERVER} --inactive-days ${INACTIVE_DAYS} --min-playtime ${MIN_PLAYTIME} > config.json;) \
    && ((while true; do sleep ${INTERVAL}; python3 update.py config.json; done;) &) \
    && httpd-foreground
