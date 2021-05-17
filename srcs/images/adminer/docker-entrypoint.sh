#!/bin/sh

echo "ADMINER STARTED"
# Start php-fpm, becoming PID 1
exec php-fpm7 -F -R
