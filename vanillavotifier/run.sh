#!/bin/bash
rcon_ip=$(dig ${rcon_host} +short)
echo "config-version: 4" > config.yaml
echo "log-directory: logs" >> config.yaml
echo "server: {port: 8192, ip: 0.0.0.0}" >> config.yaml
echo "key-pair-files: {private: private.pem, public: public.pem}" >> config.yaml
echo "on-vote:" >> config.yaml
echo "- action: rcon" >> config.yaml
echo "  server: {ip: ${rcon_ip}, port: ${rcon_port}, password: ${rcon_password}}" >> config.yaml
echo "  commands: ['scoreboard players add \${user-name} voted 1']" >> config.yaml
java -jar VanillaVotifier.jar
