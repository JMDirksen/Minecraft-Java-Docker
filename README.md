# Deploy

```
git clone https://github.com/JMDirksen/Minecraft-Java-Docker.git minecraftjava
cd minecraftjava
docker build -t minecraftjava .
docker run -it --name minecraftjava --rm -p 25565:25565 -v ./server:/data/server -e EULA=true -e level_seed=abc minecraftjava
```


# Update/Run

```
cd ~/minecraftjava
git pull
docker build -t minecraftjava .
docker rm -f minecraftjava
docker run -dit --name minecraftjava \
  --restart unless-stopped \
  -p 25565:25565 \
  -v ./server:/data/server \
  -e DEPLOYMENTID=**********
  minecraftjava
docker logs -ft minecraftjava
```
