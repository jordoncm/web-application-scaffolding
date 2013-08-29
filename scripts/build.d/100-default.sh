#!/bin/bash
# Builds the application.

cd `dirname $0`

# TODO(jordoncm): Eventually should add support for partial builds.
../../was clean

mkdir ../../build
mkdir ../../dist

python build.py "$@"

echo "... Building Distribution Files ..."

# This is a little wasteful but works fine.
cp -r ../../src ../../dist/default
rm -rf ../../dist/default/static/css
rm -rf ../../dist/default/static/js
rm -rf ../../dist/default/static/third-party/externs
cp -r ../../build/css ../../dist/default/static/
cp -r ../../build/js ../../dist/default/static/
find ../../dist/default/. -name "readme.md" -and -not -path "*/third-party/*" \
  | xargs rm

echo "... Building Application Archive ..."
cd ../../dist
tar -czf default.tgz default
