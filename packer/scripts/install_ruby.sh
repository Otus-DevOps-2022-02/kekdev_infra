#!/bin/sh
while pgrep apt; do echo "wait apt finish..."; sleep 3; done
apt update
apt install -y ruby-full ruby-bundler build-essential
