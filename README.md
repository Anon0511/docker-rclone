# docker-rclone
[Docker Hub!](https://hub.docker.com/r/anon0511/docker-rclone)

The container has a hardcoded filter for `.!qB`. This is a flag you can configure in qBittorrent to be added to unfinished Torrents, so these won't be uploaded. You can either ignore it if you aren't using qBit or you might want to start using it.

If there is need to actually allow custom filters I might think about it or you open a PR.


### Pipeline

This container is built automatically with a pipeline on a weekly schedule using alpine:latest and newest official Release of rclone!


## Usage


### docker-compose

```yaml
---
version: '3.9'
services:
  rclone-anime: &default
    image: anon0511/docker-rclone:latest
    restart: unless-stopped
    container_name: rclone-anime
    environment:
      - to_path=anime:/
      - from_path=/mnt/google/anime/
      - TZ=Europe/Berlin
      - intvl=60
      - minage=120
      - JOB=move
      - OPTS=--delete-empty-src-dirs --fast-list --dropbox-chunk-size 128M --tpslimit 12 --tpslimit-burst 12 --transfers 6 --stats-one-line
    volumes:
      - /mnt/google/anime:/mnt/google/anime
      - /home/user/.config/rclone:/var/rclone/.config/rclone
      - /home/rclone:/rclone
```


## Parameters


| Parameter | Function |
| :----: | --- |
| `TZ=Europe/Berlin` | Specify a timezone to use EG Europe/London. |
| `to_path=anime:/` | The cloud drive's name to upload to, the name must match the name in your rclone.conf. |
| `from_path=/mnt/google/anime/` | Your source directory which you mount from your host system into the container. |
| `intvl=60` | The interval on which rclone starts uploading new data. If left empty it's set to 15 min. |
| `minage=120` | The files must be older than this in minutes to be uploaded. If left empty it's set to the `intvl` time. |
| `JOB=` | Like `move` or `copy` or `sync`. |
| `OPTS=` | Additional rclone Commandline options which are not covered yet. |
| `/mnt/google/anime` | Your source directory, can be anything, must match `from_path=`. |
| `/home/user/.config/rclone` | Your personal rclone directory with the rclone.conf. |
| `/home/user/sarotate/all_accounts` | Your directory with all Service Account files, must match the path configured in the rclone.conf. |
| `/home/rclone` | The directory where rclone writes it's log to, for monitoring and debugging. |


