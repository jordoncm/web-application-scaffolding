/**
 * A sample javascript file (i.e. module).
 */

goog.provide('foo.SampleClass');

goog.require('exp');



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
  console.log('foo called');
};


/**
 * An example of an exported method.
 */
foo.SampleClass.prototype.exported = function() {
  alert('exported');
};

exp('foo.SampleClass', foo.SampleClass);
exp('foo.SampleClass.prototype.exported', foo.SampleClass.prototype.exported);
