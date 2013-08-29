/**
 * Basics for making the compiler function as expected.
 *
 * In general you should not add to or change this file unless you know what
 * you are doing.
 */

goog.provide('exp');

/**
 * A magic constant to help the compiler to know whether or not to strip calls
 * to 'console'.
 *
 * @define {boolean}
 */
var __DEBUG__ = false;

if(!__DEBUG__) {
  var console = {};
  console.debug = function() {};
  console.dir = function() {};
  console.error = function() {};
  console.group = function() {};
  console.groupCollapsed = function() {};
  console.groupEnd = function() {};
  console.info = function() {};
  console.log = function() {};
  console.profile = function() {};
  console.profileEnd = function() {};
  console.time = function() {};
  console.timeEnd = function() {};
  console.trace = function() {};
  console.warn = function() {};
}

/**
 * Export a symbol out of the compiler.
 *
 * This is a replacement for goog.exportSymbol. Did not want to require the
 * entire Closure library for a simple method to make properties available
 * outside of the compilers renaming.
 *
 * @param {string} ns The full namespace path to register the given object to.
 * @param {Object} obj The object to export.
 */
var exp = function(ns, obj) {
  var parts = ns.split('.');
  var cur = window;

  if(!(parts[0] in cur) && cur.execScript) {
    cur.execScript('var ' + parts[0]);
  }

  for(var part; parts.length && (part = parts.shift());) {
    if(!parts.length && obj !== undefined) {
      // Last part and we have an object; use it.
      cur[part] = obj;
    } else if(cur[part]) {
      cur = cur[part];
    } else {
      cur = cur[part] = {};
    }
  }
};
