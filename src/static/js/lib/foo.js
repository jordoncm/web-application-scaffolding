/**
 * @fileoverview A sample javascript file (i.e. module).
 */

goog.provide('foo.SampleClass');

goog.require('__was__');



/**
 * A sample class.
 *
 * @constructor
 */
foo.SampleClass = function() {};


/**
 * An example non-exported method.
 */
foo.SampleClass.prototype.say = function() {
  alert('foo');
  // Console statements like these will be present in debug builds of the
  // Javascript and stripped in production builds.
  console.log('foo called');
};


/**
 * An example of an exported method.
 */
foo.SampleClass.prototype.exported = function() {
  alert('exported');
};

__was__.exportSymbol('foo.SampleClass', foo.SampleClass);
__was__.exportSymbol(
  'foo.SampleClass.prototype.exported',
  foo.SampleClass.prototype.exported
);
