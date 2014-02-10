#!/bin/bash
# Lints all Python, CSS and Javascript code.
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>

exec 0< /dev/tty
cd `dirname $0`
source ../../config

echo "... Checking Python ..."

find ../../. -name "*.py" -and -not -path "*/thirdparty/*" \
  -and -not -path "*/build/*" \
  -and -not -path "*/dist/*" | xargs -I % sh -c \
  "$WAS_DEPS/py/bin/pylint --rcfile=pylint.rcfile %;"

echo "... Checking LESS ..."
PATH="$PATH:$WAS_DEPS/node-v0.10.17-linux-x64/bin"
export PATH
find ../../src/static/css -name "*.less" | xargs -I % sh -c \
  "$WAS_DEPS/node_modules/less/bin/lessc --lint %;"

echo "... Checking Javascript ..."

if [ -z "$JS_NAMESPACE" ]; then
  echo "WARNING: Javascript application namespace is not set."
fi

$WAS_DEPS/py/bin/gjslint \
  --check_html \
  --closurized_namespaces=$JS_NAMESPACE \
  --disable=2,6 \
  --jslint_error=all \
  --recurse=../../src/static/js \
  --strict \
  --unix_mode
