#!/usr/bin/env bash

if [[ $XDEBUG_ENABLED == true ]]; then

    rm -f /usr/local/etc/php/conf.d/00_xdebug.ini
    touch /usr/local/etc/php/conf.d/00_xdebug.ini
    # enable xdebug remote config
    echo "[xdebug]" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_enable=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_host=$XDEBUG_HOST" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_port=9005" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.scream=0" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.cli_color=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.show_local_vars=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo 'xdebug.idekey = "PHPSTORM"' |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo 'xdebug.remote_connect_back=1' |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null

    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    touch /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    echo zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
else
    rm -f /usr/local/etc/php/conf.d/00_xdebug.ini
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

if [[ $OPCACHE_ENABLED == true ]]; then
    echo "Enabling opcache"
else
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
fi

# run the original command
exec "$@"
