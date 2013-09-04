#!/bin/bash
# Setup the development environment.
#
# This script should likely work on any Linux flavor that is managed by an APT
# based package manager (should be easy to modify for other non-deb flavors).
#
# To reinstall any component of these base build tools, simply remove the
# folders and download files for the given product and re-execute this script.

# It is likely you could comment out these lines and install these dependencies
# manually and get this scaffolding working on Mac or non-Debian flavors of
# Linux.
sudo apt-get update
sudo apt-get install -y default-jre pylint python-setuptools unzip

################################################################################

cd `dirname $0`
PWD=`pwd`

ARCH=32
CPUINFO=`grep flags /proc/cpuinfo`
if [[ "$CPUINFO" == *" lm "* ]]; then
  ARCH=64
fi

if [ ! -d "thirdparty" ]; then
  mkdir thirdparty
fi
cd thirdparty

# Install node.js
VERSION="v0.10.17"
FILE="node-$VERSION-linux-x$ARCH"
if [ ! -e "$FILE.tar.gz" ]; then
  wget http://nodejs.org/dist/$VERSION/$FILE.tar.gz
  tar -xzf $FILE.tar.gz
  # TODO(jordoncm): This below runs the risk of stuffing the .bashrc file with
  # the path updates more than once if node.js is ever removed and reinstalled.
  echo "" >> ~/.bashrc
  echo "PATH=\$PATH:$PWD/$FILE/bin" >> ~/.bashrc
  echo "export PATH" >> ~/.bashrc
fi

# Always make sure node and npm are on the current sessions path.
PATH=$PATH:$PWD/$FILE/bin
export PATH

# node.js and LESS are a bit of a beast and has to bring in a lot of stuff to
# install. If this step errors you should be able to just re-execute this
# script and it will re-attempt picking up from where it left off.

# Install LESS.
INSTALLED=`npm list -g --depth=0 2>/dev/null | grep less`
if [ -z "$INSTALLED" ]; then
  npm install -g less
fi

# Install the Closure compiler.
if [ ! -e "compiler-latest.zip" ]; then
  wget http://closure-compiler.googlecode.com/files/compiler-latest.zip
  unzip compiler-latest.zip -d compiler-latest
fi

# Install gflags.
FILE="python-gflags-2.0"
if [ ! -e "$FILE.tar.gz" ]; then
  wget http://python-gflags.googlecode.com/files/$FILE.tar.gz
  tar -xzf $FILE.tar.gz
  cd $FILE
  sudo python setup.py install
  cd ..
fi

# Install Closure linter.
FILE="closure_linter-2.3.11"
if [ ! -e "$FILE.tar.gz" ]; then
  wget http://closure-linter.googlecode.com/files/$FILE.tar.gz
  tar -xzf $FILE.tar.gz
  cd $FILE
  sudo python setup.py install
  cd ..
fi
