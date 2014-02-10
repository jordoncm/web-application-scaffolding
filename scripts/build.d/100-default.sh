#!/bin/bash
# Builds the application.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
source ../../config

# TODO(jordoncm): Eventually should add support for partial builds.
../../was clean

mkdir $BUILD_BASE/build
mkdir $BUILD_BASE/dist

PATH="$PATH:$WAS_DEPS/node-v0.10.17-linux-x64/bin"
if [ `uname` == 'Darwin' ]; then
  PATH="$PATH:$WAS_DEPS/node-v0.10.17-darwin-x64/bin"
fi
export PATH

$WAS_DEPS/py/bin/python build.py $@ --base="$BUILD_BASE" --deps="$WAS_DEPS"

echo "... Building Distribution Files ..."

# This is a little wasteful but works fine.
cp -r ../../src $BUILD_BASE/dist/default
rm -rf $BUILD_BASE/dist/default/static/css
rm -rf $BUILD_BASE/dist/default/static/js
rm -rf $BUILD_BASE/dist/default/static/thirdparty/externs
cp -r $BUILD_BASE/build/css $BUILD_BASE/dist/default/static/
cp -r $BUILD_BASE/build/js $BUILD_BASE/dist/default/static/
find $BUILD_BASE/dist/default/. -name "readme.md" \
  -and -not -path "*/thirdparty/*" | xargs rm

echo "... Building Application Archive ..."
cd $BUILD_BASE/dist
tar -czf default.tgz default
