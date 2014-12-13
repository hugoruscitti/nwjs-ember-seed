N=[0m
V=[01;32m

VERSION=0.0.1
NAME=node-webkit-ember-seed

all:
	@echo "Comando disponibles"
	@echo ""
	@echo "  $(V)actualizar$(N)  Actualiza el repositorio e instala las dependencias."
	@echo ""
	@echo "  $(V)version$(N)     Genera la informacion de versión actualizada."
	@echo "  $(V)ver_sync$(N)    Sube la nueva version al servidor."
	@echo ""
	@echo "  $(V)server$(N)      Prueba la aplicación en el navegador."
	@echo "  $(V)build$(N)       Genera los archivos compilados."
	@echo "  $(V)watch$(N)       Genera los archivos compilados de forma contínua."
	@echo ""
	@echo "  $(V)test_mac$(N)    Prueba la aplicación sobre OSX"
	@echo ""

build:
	ember build

watch:
	ember build --watch

actualizar:
	git pull
	npm install
	bower install

test_mac: build
	@echo "Cuidado - se está usando la version de nodewebkit del sistema."
	open -a /Applications/node-webkit.app dist

version:
	# patch || minor
	@bumpversion patch --current-version ${VERSION} package.json public/package.json Makefile --list
	make build
	@echo "Es recomendable escribir el comando que genera los tags y sube todo a github:"
	@echo ""
	@echo "make ver_sync"

ver_sync:
	git commit -am 'release ${VERSION}'
	git tag '${VERSION}'
	git push
	git push --all
	git push --tags

server:
	ember server

rename:
	@echo ""
	@echo "$(V)Renaming from 'node-webkit-ember-seed' to '${NAME}' $(N)"
	@echo ""
	sed 's/node-webkit-ember-seed/${NAME}/g' public/package.json > __tmp; mv __tmp public/package.json
	sed 's/node-webkit-ember-seed/${NAME}/g' bower.json > __tmp; mv __tmp bower.json
	sed 's/node-webkit-ember-seed/${NAME}/g' app/index.html > __tmp; mv __tmp app/index.html
	sed 's/node-webkit-ember-seed/${NAME}/g' config/environment.js > __tmp; mv __tmp config/environment.js
	sed 's/node-webkit-ember-seed/${NAME}/g' tests/index.html > __tmp; mv __tmp tests/index.html


.PHONY: dist
