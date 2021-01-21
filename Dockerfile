FROM alpine:latest

ENV GROK_EXPORTER_VERSION 1.0.0.RC5
ENV ARCH amd64

# grok_exporter binary requires libc
RUN apk add --no-cache libc6-compat && \
    rm -f /var/cache/apk/*

RUN set -eux; \
    wget https://github.com/fstab/grok_exporter/releases/download/v$GROK_EXPORTER_VERSION/grok_exporter-$GROK_EXPORTER_VERSION.linux-$ARCH.zip \
    && unzip -d /opt grok_exporter-$GROK_EXPORTER_VERSION.linux-$ARCH.zip \
    && ln -s /opt/grok_exporter-$GROK_EXPORTER_VERSION.linux-$ARCH /opt/grok

EXPOSE 9144

CMD ["/opt/grok/grok_exporter", "-config", "/config.yaml"]
