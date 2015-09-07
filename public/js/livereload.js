var is_nodewebkit = (typeof process == "object");
var DELAY = 2000;
var refresh = false;

if (is_nodewebkit) {
  var fs = nodeRequire('fs');

  fs.watchFile('index.html', function() {
    if (refresh === false) {
      refresh = true;
      console.log("Detectando cambio en el archivo index.html, actualizando ...");
      setTimeout(function() {
        nodeRequire('nw.gui').Window.get().reloadIgnoringCache();
      }, DELAY);
    }
  });
}
