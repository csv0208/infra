#!/bin/bash

cd /home/appuser/
git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install
puma -d

sudo cp -fv /home/appuser/puma.service /etc/systemd/system/puma.service
sudo chmod 664 /etc/systemd/system/puma.service

sudo systemctl daemon-reload
sudo systemctl start puma
sudo systemctl enable puma

# ps aux | grep puma
# port 9292

