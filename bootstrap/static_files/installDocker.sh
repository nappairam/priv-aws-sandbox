#! /bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -d -p 80:80 ealen/echo-server
