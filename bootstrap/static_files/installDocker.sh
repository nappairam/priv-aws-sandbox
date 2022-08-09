#! /bin/bash

sudo yum update -y

sudo yum install -y jq htop

sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

sudo docker run -d -p 80:80 ealen/echo-server
