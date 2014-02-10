#!/bin/bash
# The default clean script.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
source ../../config

echo -n "Removing build and dist folders... "
rm -rf $BUILD_BASE/build
rm -rf $BUILD_BASE/dist
echo "Done"
