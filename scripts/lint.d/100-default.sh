#!/bin/bash
# Lints all Python, CSS and Javascript code.

# Comma separated list of Javascript application namespaces.
JS_NAMESPACE='foo'

cd `dirname $0`

echo "... Checking Python ..."

find ../../. -name "*.py" -and -not -path "*/third-party/*" \
  -and -not -path "*/build/*" \
  -and -not -path "*/dist/*" | xargs -I % sh -c \
  "pylint --rcfile=pylint.rcfile %;"

echo "... Checking LESS ..."
find ../../src/static/css -name "*.less" | xargs -I % sh -c \
  "lessc --lint %;"

echo "... Checking Javascript ..."

if [ -z "$JS_NAMESPACE" ]; then
  echo "WARNING: Javascript application namespace is not set."
fi

gjslint \
  --check_html \
  --closurized_namespaces=$JS_NAMESPACE \
  --disable=2,6 \
  --jslint_error=all \
  --recurse=../../src/static/js \
  --strict \
  --unix_mode
