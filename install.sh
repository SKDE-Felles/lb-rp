### Install script for docker ++ at ubuntu 20.04 (focal fossa)

# upadate system
sudo apt update

# prerequisites for https apt
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# get GPG key for docker repost
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add apt source
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# update package database
sudo apt update

# use docker repo rather than ubuntu
apt-cache policy docker-ce

# install docker
sudo apt install -y docker-ce

# add this user to docker group
sudo usermod -aG docker ${USER}

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# provide right mode to binary
sudo chmod +x /usr/local/bin/docker-compose

# (re)start dockerd
sudo systemctl daemon-reload
sudo systemctl restart docker
