FROM php:7.3-fpm-alpine
RUN apk add vim unzip
RUN apk add composer php7-iconv php7-bcmath php7-intl php7-mbstring php7-mysqli php7-pdo php7-pdo_mysql php7-opcache php7-zip php7-gd
RUN chmod +x /scripts/start.sh && rm -rf /tmp/*
RUN mkdir -p /var/run/php
RUN composer global require hirak/prestissimo
COPY fpm.conf /usr/local/etc/php-fpm.d/docker.conf
ADD start.sh /scripts/start.sh

ENTRYPOINT ["/scripts/start.sh"]

CMD ["/bin/sh"]
