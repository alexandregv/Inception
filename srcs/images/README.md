# srcs/images/

This folder contains my images. They are all stateless, which means they are not related to this very specific project.  
In fact, I reproduced a lightweight version of official images for mariadb, nginx, etc.  
They all use environment variables to customize what you need at runtime, provide folder to import your SQL seed files (`/docker-entrypoint-initdb.d`), etc.  
This is a good practice, and all images should be made this way.  
The only exception here is `minisite`, because it's my own application that I coded for this project, so it's always stateful.

As said earlier, images are made to be configurable with environment variables (see `docker-compose.yaml` for `DB_*`, `WP_*`, `FTP_*`, etc).  
Sometime, you need some more complex configuration (such as adding full configuration files), so I made the `srcs/services/` folder. See its README for full explanation.
