#!/bin/bash
# A sample application run script.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
source ../../config

ARGS=`echo -n $@ | cut -c 4-`
../../was build "$ARGS"

echo "... Running Application ..."
cd $BUILD_BASE/dist/default
