# Adminer

### Database web interface (+ php-fpm)

This one-php-file tool allows you to administrate your database via web browser. It is exposed by NGINX on `login.42.fr/adminer`, and use php-fpm similarly to the wordpress container.

It uses the `mariadb` and `nginx` networks to access the database and be reached by NGINX, which reads its data via the `adminer-data` volume.

No enviroment variable are used.

The installation and configuration is made at buildtime. It only consists of php-fpm's configuration file (`www.conf`) and a custom Adminer theme that I have chosen ([Hydra](https://github.com/Niyko/Hydra-Dark-Theme-for-Adminer)).
