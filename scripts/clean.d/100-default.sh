#!/bin/bash
# The default clean script.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

cd `dirname $0`

echo -n "Removing build and dist folders... "
rm -rf ../../build
rm -rf ../../dist
echo "Done"
