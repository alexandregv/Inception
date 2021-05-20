# MariaDB

### Database

The database is used by WordPress to store all the site content. IF you create a post or a comment, it will be stored here.

It is accessed via the `mariadb` network and uses the `mariadb-data` volume to persist data.

The connection informations are stored in all the `DB_*` environment variables (see `docker-compose.yaml`).

The MariaDB server is installed and configured on build, and the database is initialized on the first run, using the `seed.sql.tmpl` [Dockerize](https://github.com/jwilder/dockerize) template.
