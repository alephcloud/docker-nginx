# VERSION 0.1
# DOCKER-VERSION  0.9.1
# AUTHOR:         Irene Knapp <irene.knapp@icloud.com>
# DESCRIPTION:    Image with nginx installation
# TO_BUILD:       docker build -rm -t nginx .
# TO_RUN:         docker run -p 443:443 -v /media/state/nginx:/media/host registry

FROM debian-stable

RUN apt-get update; \
    apt-get install -y nginx-full puppet; \
    rm /var/lib/apt/lists/*_*; \
    rm -rf /etc/nginx; ln -s /media/host/config /etc/nginx

EXPOSE 443

CMD FACTER_docker_registry_ip=$DOCKER_REGISTRY_PORT_5000_TCP_ADDR puppet apply /media/host/manifest.pp; exec nginx
