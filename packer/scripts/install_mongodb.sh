#!/bin/sh
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
while pgrep apt; do echo "wait apt finish..."; sleep 3; done
apt update
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod
