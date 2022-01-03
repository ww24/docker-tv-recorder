# Mirakurun on Docker

## Note

Use [official one](https://github.com/Chinachu/Mirakurun/tree/master/docker) instead of this.

## Usage

### Launch / Update

```
docker compose down --rmi all
docker compose pull
docker compose up -d
```

### Copy config files

```
docker compose cp ./config/channels.yml mirakurun:/app-config/
docker compose cp ./config/server.yml mirakurun:/app-config/
docker compose cp ./config/tuners.yml mirakurun:/app-config/
```

Should be restart to apply configurations.

```
docker compose restart
```
