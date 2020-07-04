FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y apache2 \
                       vim && \
    a2enmod ssl && \
    a2ensite default-ssl

EXPOSE 80 443

ENTRYPOINT service apache2 start && tail -f /var/log/apache2/*.log
