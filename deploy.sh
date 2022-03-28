#!/bin/sh
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
IP=$(curl -sS 'https://api.ipify.org')
echo "App URL: http://$IP:9292"
