FROM alpine:3.20

RUN apk add --no-cache \
    fuse3 \
    ca-certificates \
    bash \
    curl \
    unzip

# rclone
RUN curl -LO https://downloads.rclone.org/rclone-current-linux-amd64.zip \
    && unzip rclone-current-linux-amd64.zip \
    && cp rclone-*-linux-amd64/rclone /usr/bin/ \
    && chmod +x /usr/bin/rclone \
    && rm -rf rclone*

# ps3netsrv será copiado pelo build context
COPY ps3netsrv /usr/bin/ps3netsrv
RUN chmod +x /usr/bin/ps3netsrv

RUN mkdir -p /data /cache /config \
    && echo "user_allow_other" >> /etc/fuse.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV RCLONE_CONFIG=/config/rclone.conf

ENTRYPOINT ["/entrypoint.sh"]
