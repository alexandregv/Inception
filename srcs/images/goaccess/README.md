# Goaccess

### Web log analyzer

This service allows you to inspect your HTTP logs, which can be really useful if you run a public site (such as a WordPress).
It reads your logs and then create an HTML report file. This file in then served by NGINX on `login.42.fr/goaccess`.

No network is used, not even the `nginx` one, since the only requirement is the HTML report file, which is read via the `goaccess-data` volume.
To read NGINX's logs, goaccess uses the `nginx-log` volume.

There is no environment variable used.

The simple configuration is added at buildtime, and the runtime only starts goaccess.
