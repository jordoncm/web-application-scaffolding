#!/bin/bash
# Deploys a basic application into the scaffolding.
#
# This action should really only be ran on an umodified scaffolding for
# learning purposes; it can be destructive.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`

sudo apt-get install -y python-pip
sudo pip install flask

# TODO(jordoncm): Add a warning and confirmation about potentially stomping
# application files.

cd ../..
if [ -f readme.md ]; then
  cp readme.md was.md
fi
cp -rpf sample/* .
