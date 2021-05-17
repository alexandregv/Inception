#!/bin/sh

# Start php-fpm, becoming PID 1
exec php-fpm7 --nodaemonize
