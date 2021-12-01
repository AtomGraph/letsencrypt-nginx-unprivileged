FROM atomgraph/nginx-unprivileged:25644205c4f1377ee6919f7fedd48e3a2e2f4223

LABEL maintainer="martynas@atomgraph.com"

USER root

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get install -y python3-certbot-dns-route53 && \
    mkdir -p /etc/letsencrypt/live && \
    chown -R nginx:nginx /etc/letsencrypt/live && \
    mkdir -p /var/log/letsencrypt && \
    chown -R nginx:nginx /var/log/letsencrypt && \

USER nginx