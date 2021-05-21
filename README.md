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

1. Run `make`
3. Open [https://aguiot--.42.fr/](https://aguiot--.42.fr/)

## More commands

* Start all and follow logs: `make run`
* Start all in background: `make upd`
* Show services and their status: `make ps`
* Down all: `make down` (`downv` for volumes)
* Clean all: `make clean` (`fclean` for volumes and their data)
* Full reset: `make re`
* Up one specific service: `make <service>.up` (`upd`for background)
* Down one specific service: `make <service>.down` (`downv`for volumes)
* Get logs of one specific service: `make <service>.logs` (`logsf` to follow)
* Start shell in one specific service: `make <service>.shell` (`shell.root` to be root)
* Start client of one specific service: `make <service>.client` (e.g redis-cli for redis)
* Build all: `make build`
* Build one specific service: `make <service>.build`
* Generate SSL certificate: `make ssl`
