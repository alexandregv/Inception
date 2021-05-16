#!/bin/sh

# wait for database
dockerize -wait tcp://"$DB_HOST":3306

if wp-cli core is-installed; then
	echo "WordPress is already installed, starting..."
else
	echo "WordPress is not installed, installing..."
	wp-cli core install --url="localhost/wordpress" --title="aguiot--'s Inception" --admin_user="wordpress" --admin_password="wordpress" --admin_email="wordpress@mail.com" --skip-email
	wp-cli theme activate twentytwentyone
	echo "Installation done, starting..."
fi

# start php-fpm, becoming PID 1
exec php-fpm7 -F -R
