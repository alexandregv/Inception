#!/bin/sh

# wait for database
dockerize -wait tcp://"$DB_HOST":3306

if wp-cli core is-installed; then
	echo "WordPress is already installed, starting..."
else
	echo "WordPress is not installed, installing..."
	wp-cli core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_MAIL" --skip-email
	if [ -n "$WP_THEME" ] && ! wp-cli theme is-active "$WP_THEME"; then
		wp-cli theme activate "$WP_THEME"
	fi
	echo "Installation done, starting..."
fi

# start php-fpm, becoming PID 1
exec php-fpm7 -F -R
