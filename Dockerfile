FROM atomgraph/nginx-unprivileged:25644205c4f1377ee6919f7fedd48e3a2e2f4223

LABEL maintainer="martynas@atomgraph.com"

USER root

RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get install -y python3-certbot-dns-route53 && \
    workdir=$(pwd) && \
    cd $(mktemp -d) && \
    curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    cd "$workdir" && \
    mkdir -p /etc/letsencrypt && \
    chown -R nginx:nginx /etc/letsencrypt && \
    mkdir -p /var/log/letsencrypt && \
    chown -R nginx:nginx /var/log/letsencrypt && \
    mkdir -p /var/lib/letsencrypt && \
    chown -R nginx:nginx /var/lib/letsencrypt

USER nginx