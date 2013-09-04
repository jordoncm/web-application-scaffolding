#!/bin/bash
# A sample application run script.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

cd `dirname $0`

../../was build

echo "... Running Application ..."
cd ../../dist/default
python app.py
