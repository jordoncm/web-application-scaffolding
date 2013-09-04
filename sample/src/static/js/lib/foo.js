/**
 * @fileoverview A sample javascript file (i.e. module).
 *
 * Function calls goog.provide and goog.require are used by the compiler to
 * establish the hierarchy of the Javascript and will not appear in the
 * compiled Javascript output.
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
 *
 * This exportSymbol mehtod is used to give unobfuscated access to portions of
 * you while compiling the rest.
 */
foo.SampleClass.prototype.exported = function() {
  alert('exported');
};

__was__.exportSymbol('foo.SampleClass', foo.SampleClass);
__was__.exportSymbol(
  'foo.SampleClass.prototype.exported',
  foo.SampleClass.prototype.exported
);
