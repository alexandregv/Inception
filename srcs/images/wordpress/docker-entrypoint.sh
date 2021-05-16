#!/bin/sh

if wp-cli core is-installed; then
	echo "WordPress is already installed, starting..."
else
	echo "WordPress is not installed, installing..."
	wp-cli core install --title='yay' --admin_user='wordpress' --admin_password='wordpress' --admin_email='wordpress@mail.com' --skip-email:w
	echo "Installation done, starting..."
fi

exec php-fpm7 -F -R
