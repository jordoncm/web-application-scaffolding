WAS: scripts
============

The scripts folder contains the scripts that power the main `was` script
execution.

Typically you should not call these scripts directly. Use the `was` script in
the root directory for task execution and any customizations should done using
preflight or postflight scripts (see below).

Workflow Customization (preflight and postflight scripts)
---------------------------------------------------------

The execution details for each scaffolding task (`was ACTION`) is kept in a
`*.d` subfolder (i.e. `build.d`). When a task is called in the `was` script,
every script file (`*.sh`) in its corresponding folder is executed in order by
its name. All command line arguments passed to the `was` script will also be
passed along to each sub-script (including the action).

To customize the actions taken you can either modify the scripts in each folder
or drop new ones in place named in the correct order. The naming conventions
for script files is as follows:
  - 0*XX*-preflight-*name*.sh: Used for preflight scripts. Steps to take before
    the default action.
  - 1*XX*-*name*.sh: Steps in the main execution of the task.
  - 0*XX*-postflight-*name*.sh: Used for postflight scripts. Steps to take
    after the default action has completed.
