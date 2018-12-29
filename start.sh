#!/usr/bin/env bash

if [[ $XDEBUG_ENABLED == true ]]; then
    
    rm -f /usr/local/etc/php/conf.d/00_xdebug.ini
    touch /usr/local/etc/php/conf.d/00_xdebug.ini
    # enable xdebug remote config
    echo "[xdebug]" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_enable=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_host=host.docker.internal" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.remote_port=9005" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.scream=0" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.cli_color=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo "xdebug.show_local_vars=1" |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null
    echo 'xdebug.idekey = "PHPSTORM"' |  tee -a /usr/local/etc/php/conf.d/00_xdebug.ini > /dev/null

fi

# run the original command
exec "$@"
