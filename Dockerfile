FROM php:7.4-fpm-alpine
RUN apk add vim unzip bash composer
RUN apk add --no-cache \
		icu-dev \
		zlib-dev \
		libzip-dev \
		libpng-dev  \
		libjpeg-turbo \
		freetype freetype-dev \
		libjpeg-turbo-dev \
		libwebp-dev \
		libxpm-dev \
		oniguruma-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install iconv bcmath mbstring mysqli pdo pdo_mysql opcache zip gd exif
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.9.0 \
    && docker-php-ext-enable xdebug
RUN mkdir -p /var/run/php
RUN composer global require hirak/prestissimo
COPY fpm.conf /usr/local/etc/php-fpm.d/docker.conf
ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh && rm -rf /tmp/*

ENTRYPOINT ["/scripts/start.sh"]

CMD ["/bin/bash"]
