FROM alpine:latest

VOLUME ["/var/rclone"]
RUN apk add --no-cache su-exec bash curl unzip
RUN apk add --update tzdata
RUN curl https://rclone.org/install.sh | bash
RUN rm -rf /var/cache/apk/*
COPY ./entrypoint.sh /bin/entrypoint.sh
COPY ./rclone_start.sh /bin/rclone_start.sh

ENV PUID=0 PGID=0 HOME=/var/rclone
RUN mkdir -p /var/rclone/.config/rclone
RUN chmod 777 /bin/entrypoint.sh
RUN chmod 777 /bin/rclone_start.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
