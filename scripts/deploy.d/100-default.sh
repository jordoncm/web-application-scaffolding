#!/bin/bash
# Deploys application into production.
#
# This script is just a blank stub. Modify this to fit your environment.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
source ../../config

ARGS=`echo -n $@ | cut -c 7-`
../../was build "$ARGS"

echo "... Deploying Application ..."
