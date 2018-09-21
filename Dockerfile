FROM php:7.3-rc-fpm
RUN apt-get update
RUN apt-get install -y libicu-dev \
        libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
		vim
RUN docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) iconv bcmath intl mbstring mysqli pdo pdo_mysql
RUN pecl install xdebug-2.7.0beta1 \
	&& docker-php-ext-enable xdebug
RUN apt-get clean
COPY fpm.conf /usr/local/etc/php-fpm.d/docker.conf
ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh && rm -rf /tmp/*
RUN mkdir -p /var/run/php

ENTRYPOINT ["/scripts/start.sh"]

CMD ["/bin/bash"]