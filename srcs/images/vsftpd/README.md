# vsftpd

### FTP server

vsftpd (Very Secure FTP Daemon) allows to run an FTP server and to access or edit WordPress files with an user-friendly GUI client (i.e FileZilla).

It exposes port `21` for initial FTP connection and ports `21000` to `21010` for Passive Mode connections.
The `wordpress-data` volumes allows to read/edit WP files, and the `ssl` volume allows to use the SSL certificate to encrypt the connection.

The username/password and Passive Mode port range can be configured with the `FTP_*` environment variables (see `docker-compose.yaml`).

The file permissions and configuration are handled at runtime. [Dockerize](https://github.com/jwilder/dockerize) is used to parse the configuration template (`vsftpd.conf.tmpl`).
