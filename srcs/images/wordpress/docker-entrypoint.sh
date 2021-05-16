#!/bin/sh

if wp-cli core is-installed; then
	echo "WordPress is already installed, starting..."
else
	echo "WordPress is not installed, installing..."
	wp-cli core install --title='yay' --admin_user='wordpress' --admin_password='wordpress' --admin_email='wordpress@mail.com' --skip-email
	echo "Installation done, starting..."
fi

exec dockerize -wait tcp://"$DB_HOST":3306 php-fpm7 -F -R
