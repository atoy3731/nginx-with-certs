FROM alpine:latest

RUN apk update && \
    apk add openssl nginx

RUN mkdir -p /run/nginx

COPY files/default.conf /etc/nginx/conf.d/default.conf
COPY files/entrypoint.sh /opt/entrypoint.sh

CMD [ "/bin/ash", "/opt/entrypoint.sh" ]