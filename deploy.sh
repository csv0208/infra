#!/bin/bash

cd /home/appuser/
git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install
pumd -d
ps aux | grep puma
# port 9292
