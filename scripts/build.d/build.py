#!/usr/bin/which python
#
# Copyright (c) 2013 Jordon Mears.
#
# Web Application Scaffolding is made available under the MIT license.
# <http://opensource.org/licenses/MIT>
"""Compiles the LESS and Javascript code."""

import os
import subprocess
import sys

import gflags

FLAGS = gflags.FLAGS
gflags.DEFINE_boolean(
  'debug',
  False,
  'If set will still process files but not obfuscate code.'
)
gflags.DEFINE_string(
  'base',
  '../..',
  'The base path in which to place the build and dist folders.'
)
gflags.DEFINE_string(
  'deps',
  '../../thirdparty',
  'The base path for scaffolding dependencies.'
)

def main(argv):
  """Executes the build."""

  # If script is executed from the main 'was' script we need to drop the action
  # option in order for gflags to process the options correctly.
  if argv[1] == 'build':
    del argv[1]

  # Parse the command line flags.
  try:
    argv = FLAGS(argv)
  except gflags.FlagsError, error:
    print '%s\\nUsage: %s ARGS\\n%s' % (error, sys.argv[0], FLAGS)
    sys.exit(1)

  if FLAGS.debug:
    print 'Compiling in debug mode.'

  print '... Compiling LESS ...'
  build_less(FLAGS.base, FLAGS.debug, FLAGS.deps)
  print '... Compiling Javascript ...'
  build_javascript(FLAGS.base, FLAGS.debug, FLAGS.deps)

def build_less(base, debug=False, deps='../../thirdparty'):
  """Builds LESS files into compiled CSS."""
  src_folder = '../../src/static/css'
  targets = os.listdir(src_folder)
  build_folder = os.path.join(base, 'build/css')
  os.mkdir(build_folder)
  command = os.path.join(deps, 'node_modules/less/bin/lessc')
  for target in targets:
    src = os.path.join(src_folder, target)
    if os.path.isfile(src):
      dest = os.path.join(build_folder, target.replace('.less', '.css'))
      # Process both LESS and CSS files. CSS files will at least benefit from
      # minification.
      if target.endswith('.less') or target.endswith('.css'):
        if debug:
          subprocess.call([command, src, dest])
        else:
          subprocess.call([command, '--clean-css', src, dest])

def build_javascript(base, debug=False, deps='../../thirdparty'):
  """Compiles Javascript."""
  src_folder = '../../src/static/js'
  targets = os.listdir(src_folder)
  build_folder = os.path.join(base, 'build/js')
  os.mkdir(build_folder)

  extra_args = []

  optimization_level = 'ADVANCED_OPTIMIZATIONS'
  if debug:
    optimization_level = 'SIMPLE_OPTIMIZATIONS'
    extra_args.append('--formatting')
    extra_args.append('PRETTY_PRINT')
    extra_args.append('--define=\'__DEBUG__=true\'')

  externs = recurse_build_args(
    '../../src/static/thirdparty/externs',
    '--externs'
  )
  externs = externs + recurse_build_args(
    os.path.join(src_folder, 'externs'),
    '--externs'
  )
  js_args = recurse_build_args(os.path.join(src_folder, 'lib'))

  for target in targets:
    src = os.path.join(src_folder, target)
    is_file = os.path.isfile(src)
    if is_file and target.endswith('.js') and target != 'typedefs.js':
      dest = os.path.join(build_folder, target)
      command = [
        'java', '-jar', os.path.join(deps, 'compiler-latest/compiler.jar'),
        '--compilation_level', optimization_level,
        '--manage_closure_dependencies',
        '--process_closure_primitives',
        '--js', '../../src/static/js/typedefs.js',
        '--js', src,
        '--js_output_file', dest
      ] + extra_args + externs + js_args
      subprocess.call(command)

def recurse_build_args(base_path, arg_name='--js'):
  """Recurses a directory structure generating a list of Closure arguments."""
  args = []
  files = os.listdir(base_path)
  for filename in files:
    path = os.path.join(base_path, filename)
    if os.path.isdir(path):
      args = args + recurse_build_args(path, arg_name)
    elif os.path.isfile(path) and filename.endswith('.js'):
      args.append(arg_name)
      args.append(path)

  return args

if __name__ == '__main__':
  main(sys.argv)
