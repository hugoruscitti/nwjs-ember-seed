var is_nodewebkit = (typeof process == "object");

if (is_nodewebkit) {
  window.onkeypress = function(e) {
    if (e.which === 105 && (e.ctrlKey || e.shiftKey || e.metaKey)) {
      nodeRequire('nw.gui').Window.get().showDevTools();
    }
  };
}
