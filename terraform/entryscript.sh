#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sleep 10
sudo usermod -aG docker ec2-user   # add ec2-user to docker group, so we can run docker command without sudo

# install docker compose 
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose