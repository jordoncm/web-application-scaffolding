# Web Application Scaffolding

This project provides a self contained script that provides a basic set of
tools, code and folder structure to develop a full web based application.

The scaffolding selects a couple basic tools to help ease the process of
compiling and deploying CSS and Javascript for a production application. The
scaffolding was designed to be simple and easy to customize and extend.

The scaffolding is setup to build and deploy Python based web applications by
default but it should be general and easy enough to remove the Python specific
stuff and replace it for another server side technology (also works well for
static Javascript applications).

## Getting was

To use was all you need to do is download the `was` script to your computer.

Make sure the file is executable:

```shell
chmod +x was
```

If you want you can also add the `was` script to your PATH by adding a function
for it in your `~/.bashrc`:

```shell
function was() { /the/full/path/to/where/you/saved/was "$@" ;}
```

The scaffolding script is written in Python and only designed to work with
Linux. It expects that you have Python installed with pip. It will detect and
install its dependencies automatically.

**WARNING:** It will use pip to install a few packages (invoke, gflags, pylint)
to the current Python environment. I highly suggest using a Python virtual
environment (virtualenv) to keep unwanted packages from being installed to the
system Python. It is likely you should be doing this for your development
project anyway. This can be done by:

```shell
sudo apt-get install python-virtualenv
virtualenv was
source was/bin/activate
```

### invoke bug currently breaks was

The `was` script uses the Python package [invoke](http://www.pyinvoke.org/)
extensively, however there is a bug that breaks was. I have a submitted a [pull
request](https://github.com/pyinvoke/invoke/pull/288) to fix this, but for now
you need to install `invoke` manually from my
[forked version](https://github.com/jordoncm/invoke).

## Using was

Once you have the `was` script in place you can see what it is capable of by:

```shell
was --list
```

The general workflow for a new web project using `was` is:

```shell
mkdir fooproject
cd fooproject
was init
```

This will create a new folder structure inside of `fooproject` with which to
build out your web application. The structure looks like:

```shell
src
# This is where your actual application source should live.

src/static
# This is where all static files for the application should live.

src/static/thirdparty
# This is where all third party code that is served statically to the client
should live (things like jQuery, Bootstrap, Font Awesome, etc).

src/thirdparty
# This is where all server side third party code (or binaries) should live that
# need included in the resulting artifact after building (it will be copied
# into the dist artifact).

thirdparty
# This is where any third party build tools or supporting libraries should
# live. They can be used in the build process but will not be copied into the
# resulting artifact after building.
#
# This is also where the was script itself places its dependent libraries.


# CSS is compiled using Less.js by default. Each of the main source files is
# compiled independently and then copied into the resulting artifact.

src/static/css
# This is where any root CSS (Less.js) files should live. Only the main files
# should be in this folder (i.e. the ones you will reference in a link tag).

src/static/css/lib
# This is where the reusable (library) CSS (Less.js) files should live. These
# are the ones you will import into your main files at build time. This folder
# will not get copied into the resulting artifact and code will only be
# included if it is used in your main files at compile time.


# Javascript is compiled using the Closure Compiler by default. Each of the
# main source files is compiled independently and then copied into the
# resulting artifact.

src/static/js
# This is where any root Javascript files should live. Only the main files
# should be in this folder (i.e. the ones you will reference in a script tag).

src/static/js/externs
# This is where externs files should be placed. Every Javascript file in this
# folder will be passed as an externs file to the compiler.
#
# https://developers.google.com/closure/compiler/docs/api-tutorial3?hl=en#externs

src/static/js/lib
# This is where the reusable (library) Javascript files should live. These are
# the ones you will import into your main files at build time. This folder will
# not get copied into the resulting artifact and code will only be included if
# it is used in your main files at compile time.
#
# For the Closure Compiler this is done using goog.provide and goog.require.

src/static/thirdparty/externs
# This is where externs files should be placed that came from third party
# sources. Every Javascript file in this folder will be passed as an externs
# file to the compiler. Many popular Javascript libraries have externs files
# written and available so you don't have to create them on your own.
```

After the project is intialized the basic workflow is to add your source code
in the proper locations and then build, run and deploy.

```shell
was build
# By default compiles the CSS and Javascript and copies files into the dist
# folder. Any extra build steps need to be added in yourself (i.e. a javac for
# the main source or whatever).

was build.debug
# This is the same a build but passes debug flags to both Less.js and the
# Closure Compiler.

was run
# This is a blank stub that will only run a build. It must be customized in
# order to spin up a local instance of your application (i.e. kick off a Python
# web server, etc).

was deploy
# This is a blank stub that will only run a build. It must be customized in
# order to package and deploy you appilcation.
```

Other useful commands in the `was` script are:

```shell
was search
# This is just a wrapper on grep that will properly ignore thirdparty folder
# and just search the project source code.

was lint
# Runs the Less.js linter over all of the CSS, the Closure Linter over the
# Javascript and pylint over the src folder.

was test
# This is just a blank stub at this point. It can be customized like any other
# task. May add support for certain CSS and Javascript frameworks in the
# future.

was deps
# These tasks will grab and install all the direct dependencies that make the
# was script function. This should be customized to also bring in any project
# dependencies as well.
```

## Modifying to Suite Project Needs

The scaffolding is really just meant to provide basic primitives and be
customized to suite each projects needs. You do this by flushing out the main
section of each command and then change the dependent tasks as needed. Each
command (build, run, deploy, etc) is empty by default, you will find them as
Python methods at the bottom of the `was` script file. See the file itself for
more information.

--------------------------------------------------------------------------------

## Note About Third Party Code

One of the fundamental aspects of this scaffolding is to isolate all third
party application code away from the rest of the source code for projects built
on this scaffolding. This helps make code isolation and usage an intrinsic part
of the software process and help identify code that may be untrusted or have
licensing issues in your project.

All third party code should be placed (unmodified) into folders named
`thirdparty` throughout the code base. The default build rules will treat this
source differently and skip steps like minification or compiling into the main
source. Use custom build rules to handle this code by modifying the workflows
at the bottom of the `was` script.

--------------------------------------------------------------------------------

Copyright (c) 2013 - 2015 Jordon Mears.

Web Application Scaffolding is made available under the MIT license.
<http://opensource.org/licenses/MIT>
