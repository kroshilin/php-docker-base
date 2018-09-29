FROM php:7.2-fpm
RUN apt-get update
RUN apt-get install -y libicu-dev \
        libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
		vim \
		unzip
RUN docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) iconv bcmath intl mbstring mysqli pdo pdo_mysql opcache zip
RUN pecl install xdebug-2.6.1 \
	&& docker-php-ext-enable xdebug
RUN apt-get clean
COPY fpm.conf /usr/local/etc/php-fpm.d/docker.conf
ADD start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh && rm -rf /tmp/*
RUN mkdir -p /var/run/php
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php && \
	php -r "unlink('composer-setup.php');" && \
	mv composer.phar /usr/local/bin/composer
RUN composer global require hirak/prestissimo

ENTRYPOINT ["/scripts/start.sh"]

CMD ["/bin/bash"]