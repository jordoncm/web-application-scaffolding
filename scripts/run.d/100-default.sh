#!/bin/bash
# A sample application run script.

cd `dirname $0`

../../was build

echo "... Running Application ..."
cd ../../dist/default
python app.py
