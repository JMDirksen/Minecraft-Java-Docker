# Deploy

```
git clone https://github.com/JMDirksen/Minecraft-Java-Docker.git minecraftjava
cd minecraftjava
docker build -t minecraftjava .
```


# Update/Run

```
cd ~/minecraftjava
git pull
docker build -t minecraftjava .
docker rm -f minecraftjava
docker run -dit --name minecraftjava -v ./server:/data/server -e EULA=true -e level_seed=abc minecraftjava
docker logs -ft minecraftjava
```
