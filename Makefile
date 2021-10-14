all: env docker-compose nginx

env:
	cp srv-admin/env.template srv-admin/.env

docker-compose: /usr/bin/docker-compose 
/usr/bin/docker-compose: /usr/bin/docker
	sudo add-apt-repository universe
	sudo apt-get update
	sudo apt-get install -y docker-compose
	sudo usermod -aG docker $(USER)


/usr/bin/docker:
	sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

nginx: /usr/sbin/nginx /etc/nginx/sites-enabled/app.conf
/usr/sbin/nginx:
	sudo apt-get update
	sudo apt-get install -y nginx

/etc/nginx/sites-enabled/app.conf:
	sudo rm -f /etc/nginx/sites-enabled/default
	sudo ln -sf $(LOCAL)srv-webserver/$(SRV_NGINX) $(GLOBAL)$(SRV_NGINX)

LOCAL := $(shell pwd)/
GLOBAL := /

SRV_NGINX := etc/nginx/sites-enabled/app.conf