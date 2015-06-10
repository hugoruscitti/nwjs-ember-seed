window.onkeypress = function(e) {
  if (e.which === 105 && (e.ctrlKey || e.shiftKey || e.metaKey)) {
    require('nw.gui').Window.get().showDevTools();
  }
}
