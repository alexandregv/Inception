#!/bin/sh

# Wait for database
dockerize -wait tcp://"$DB_HOST":3306 -timeout 30s

if wp-cli core is-installed; then
	echo "WordPress is already installed, starting..."
else
	echo "WordPress is not installed, installing..."

	# Install WordPress with admin user (auto generated password if not provided)
	if [ -n "$WP_ADMIN_PASS" ]; then
		wp-cli core install --url="$WP_URL" --title="$WP_TITLE" --skip-email --admin_email="$WP_ADMIN_MAIL" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS"
		echo "Admin password: $WP_ADMIN_PASS"
	else
		wp-cli core install --url="$WP_URL" --title="$WP_TITLE" --skip-email --admin_email="$WP_ADMIN_MAIL" --admin_user="$WP_ADMIN_USER"
	fi

	echo "Installing redis-cache plugin..."
	wp-cli plugin install redis-cache
	wp-cli plugin activate redis-cache
	wp-cli redis enable

	# Create 2 default users (auto generated passwords)
	echo "Creating user 'bob'..."
	wp-cli user create bob bob@example.com --role=author
	echo "Creating user 'alice'..."
	wp-cli user create alice alice@example.com

	echo "Installation done, starting..."
fi

# Activate theme if needed
if [ -n "$WP_THEME" ] && ! wp-cli theme is-active "$WP_THEME"; then
	wp-cli theme activate "$WP_THEME"
fi

# Test FPM configuration and exit if invalid
#if ! php-fpm7 --test; then
#	echo "FPM configuration file is invalid, exiting."
#	exit 1
#fi

# Make sure logfiles exist
touch /var/log/php7/access.log /var/log/php7/error.log

# Start php-fpm via dockerize, becoming PID 1
exec dockerize -stdout /var/log/php7/access.log -stderr /var/log/php7/error.log php-fpm7 --nodaemonize
