#!/bin/bash
# The default clean script.

cd `dirname $0`

echo -n "Removing build and dist folders... "
rm -rf ../../build
rm -rf ../../dist
echo "Done"
