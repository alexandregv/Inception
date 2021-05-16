#!/bin/sh

# Build seed.sql from template
dockerize -template /seed.sql.tmpl:/tmp/seed.sql

# Start temporary mariadb server
echo "Starting temporary server..."
mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock --port=3307 &

# Wait for temporary server to be alive, exit if it fails
if ! mariadb-admin --socket=/var/lib/mysql/mysql.sock --wait=25 ping; then
	echo "Temporary server couldn't start, exiting"
	exit 1
fi

# Import seed if database does not exist yet
if ! (mariadb --socket=/var/lib/mysql/mysql.sock -e "SHOW DATABASES LIKE '$DB_NAME';" | grep -q "$DB_NAME"); then
	echo "Initializing database..."
	mariadb --socket=/var/lib/mysql/mysql.sock < /tmp/seed.sql
else
	echo "Database is already initialized."
fi

# Stop temporary mariadb server
mariadb-admin --socket=/var/lib/mysql/mysql.sock shutdown

# Start real server, passing CMD and becoming PID 1
echo "Starting mariadb daemon..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock --port=3306 $@ 
