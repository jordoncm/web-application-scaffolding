#!/bin/bash
# Copies the scaffolding to a target directory.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
cd ../..

if [ ! -d "$2" ]; then
  echo -n "Cloning scaffolding to target directory... "
  mkdir $2
  cp -rp * $2
  cp .gitignore $2
  rm -rf $2/build
  rm -rf $2/dist
  echo "Done"
else
  echo "Target directory already exists, exiting."
fi
