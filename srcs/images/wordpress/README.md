# WordPress + php-fpm

### CMS + PHP

This container holds the WordPress installation, and the associated php-fpm process, which will be reached by NGINX to execute WP's php files.

It uses the `nginx` network to do so, but also the `mariadb` and `redis` networks to connect to the database and the cache store.
WordPress data is stored in the `wordpress-data` volume, which is also used by NGINX.

The WordPress installation can be configured with all the `WP_*` environment variables (see `docker-compose.yaml`), as well as the database connection with the `DB_*` variables.

The WP CLi is installed at buildtime, but the site installation is made at runtime (because it needs infos about this specific site installation).
