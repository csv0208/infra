#!/bin/bash
cd /home/appuser/

## install ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

## install mongodb-org
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt update
sudo apt install -y mongodb-org

sudo systemctl start mongod
sudo systemctl enable mongod

## deploy puma-server

git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install
puma -d
# ps aux | grep puma
# port 9292

