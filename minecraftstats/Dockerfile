FROM httpd
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git python3
RUN rm -rf /usr/local/apache2/htdocs
RUN git clone https://github.com/pdinklag/MinecraftStats.git /usr/local/apache2/htdocs
VOLUME /minecraft
WORKDIR /usr/local/apache2/htdocs
ENV SERVER=/minecraft
ENV INTERVAL=60
CMD (python3 makeconfig.py --server ${SERVER} > config.json;) \
    && ((while true; do python3 update.py config.json; sleep ${INTERVAL}; done;) &) \
    && httpd-foreground
