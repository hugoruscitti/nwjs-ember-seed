var is_nodewebkit = (typeof process == "object");

if (is_nodewebkit) {
  window.ember_require = window.require;

  window.require = function(module) {
    return window.ember_require(module);
  }
}
