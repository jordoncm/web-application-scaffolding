#!/bin/bash
# Deploys a basic application into the scaffolding.

cd `dirname $0`

sudo apt-get install -y python-pip
sudo pip install flask
