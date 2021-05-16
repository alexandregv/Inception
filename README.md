# Inception

First 42 project about Docker and Docker Compose.  
Basically a LEMP stack: Linux, Nginx, MariaDB, PHP. (Yes the E is for Nginx, if you don't know why then you never spelled it correctly.)  

## Installation

1. `git clone https://github.com/alexandregv/Inception.git`
2. `cd Inception`
3. `cp srcs/.env.sample srcs/.env` (Create .env file from sample)
4. `vim srcs/.env` (Fill .env file)
5. `sudo sh -c 'echo "127.0.0.1 aguiot--.42.fr" >> /etc/hosts'` (Add fake domain to `hosts` file)

## Usage

1. `make build` (Build all images)
2. `make upd logsf` (Start in background + follow logs)
3. Open [http://localhost/wordpress](http://localhost/wordpress)
