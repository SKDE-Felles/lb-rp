# Mongr load balancer and reverse proxy <img src="logo.svg" align="right" height="150" />

Adjusted with our own flavour, but mostly by re-using existing and excellent [code](https://github.com/wmnnd/nginx-certbot) and [step-by-step guide](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)

## Introduction
The name _lb-rp_ is a condenced form of _load blancer - reverse proxy_ and is part of the infrastructure hosting web application developed and mentained by _SKDE_. _lb-rp_ is based on [NGINX Open Source](https://www.nginx.com/) and applied as a [docker container](https://www.yr.no/place/Norway/Troms_og_Finnmark/Troms%C3%B8/Troms%C3%B8/hour_by_hour.html) alongside our config and other cogs that make up [mongr.no](https://mongr.no):

![mongr.no architecture](mongr_arch.png)

Our application of NGINX as proxy and load balancer is descibed below. Description of the other parts can be found elsewhere, for instance [our shinyproxy](https://github.com/SKDE-Felles/shinyproxy) and the [qmongr shiny application](https://github.com/SKDE-Felles/qmongr).

## Config
Configuration of NGINX is defined in the _data/nginx/mongr.conf_-file. Please refere to the [NGINX documentation](https://nginx.org/en/docs/) and relevant settings of the hosting environment. All changes must be committed to this repository using git.

## Install
All steps are performed from the command line at the server instance that will be running the nginx service. Make sure that the content of this repo is available at the server by using git:
```
git clone https://github.com/mong/lb-rp.git
```
the first time. For consecutive updates navigate into the lb-rp directory and issue:
```
git pull origin master
```

### First time
If the server to be hosting nginx is just created (vanilla state) make sure _docker-ce_ and _docker-compose_ are installed along with other relevant settings by running the following script:
```
sudo ./install.sh
```

Then, make sure that the values set at the top 15-ish lines of _init-letsencrypt.sh_ are sensible and run the script:
```
./init-letsencrypt.sh
```

This ensures that users can connect securely to our site by the kind help of [Let's Encrypt](https://letsencrypt.org/about/).

As a result of running the above script the nginx docker container is now running but should at this stage be taken down by:
```
docker kill $(docker ps -q)
```

### Update
Both the _nginx_ and its accompanying _certbot_ container are configured to regularly refresh config and certificates. Any changes or updates should therefore a matter of just updating from the github repository. Move into the _lb-rp_ directory and issue:
```
git pull origin master
```
and the rest should take care of itself. If waiting it out is not an option the services can also be manually restarted as described below.

## Start and stop service
To enable _lb-rp_ use _docker-compose_ to start the relevant services in detached mode:
```
docker-compose up -d
```

To stop the same services do:
```
docker-compose down
```

To bring the services down an up again in one go do:
```
docker-compose restart
```

For other options please consult [the docker compose docs](https://docs.docker.com/compose/).
