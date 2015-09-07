var is_nodewebkit = (typeof process == "object");

if (is_nodewebkit) {
  window.node_require = window.require;
  window.nodeRequire = window.require;
}
