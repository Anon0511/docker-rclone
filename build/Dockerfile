FROM alpine:latest

ENV RCLONE_VERSION=1.65.5
ENV ARCH=amd64

VOLUME ["/var/rclone"]
RUN apk add --no-cache su-exec bash curl unzip openssl ca-certificates fuse3
RUN apk add --update tzdata
RUN cd /tmp \
    && wget -q https://github.com/divyam234/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip \
    && unzip /tmp/rclone-v${RCLONE_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone* \
    && addgroup rclone \
    && adduser -h /var/rclone -s /bin/ash -G rclone -D rclone
RUN rm -rf /var/cache/apk/*
COPY ./entrypoint.sh /bin/entrypoint.sh
COPY ./rclone_start.sh /bin/rclone_start.sh

ENV PUID=1000 PGID=1000 HOME=/var/rclone

RUN mkdir -p /var/rclone/.config/rclone
RUN chmod 777 /bin/entrypoint.sh
RUN chmod 777 /bin/rclone_start.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
