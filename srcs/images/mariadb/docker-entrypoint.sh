#!/bin/sh

# Build seed.sql from template
dockerize -template /seed.sql.tmpl:/tmp/seed.sql

# Start temporary mariadb server
echo "Starting temporary server..."
mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock --port=3307 &
dockerize -wait tcp://localhost:3307

# Import seed if database does not exist yet
if ! (mariadb --socket=/var/lib/mysql/mysql.sock -e "SHOW DATABASES LIKE '$DB_NAME';" | grep -q "$DB_NAME"); then
	echo "Initializing database..."
	mariadb --socket=/var/lib/mysql/mysql.sock < /tmp/seed.sql
else
	echo "Database is already initialized."
fi

# Kill temporary mariadb server
pkill mariadbd
sleep 3

# Start real server, passing CMD and becoming PID 1
echo "Starting mariadb daemon..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock $@ 
