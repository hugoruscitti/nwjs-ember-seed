VERSION=0.0.1
NOMBRE="TXTNOMBRE"

N=[0m
G=[01;32m
Y=[01;33m
B=[01;34m

comandos:
	@echo ""
	@echo "${B}Comandos disponibles para ${G}TXTNOMBRE${N}"
	@echo ""
	@echo "  ${Y}Para desarrolladores${N}"
	@echo ""
	@echo "    ${G}iniciar${N}         Instala dependencias."
	@echo "    ${G}compilar${N}        Genera los archivos compilados."
	@echo "    ${G}compilar_live${N}   Compila de forma contínua."
	@echo ""
	@echo "    ${G}ejecutar_linux${N}  Prueba la aplicacion sobre Huayra."
	@echo "    ${G}ejecutar_mac${N}    Prueba la aplicacion sobre OSX."
	@echo ""
	@echo "    ${G}actualizar_tema${N} Descargar e inyecta el tema de huayra."
	@echo ""
	@echo "  ${Y}Para distribuir${N}"
	@echo ""
	@echo "    ${G}version${N}         Genera una nueva versión."
	@echo "    ${G}subir_version${N}   Sube version generada al servidor."
	@echo "    ${G}log${N}             Muestra los cambios desde el ultimo tag."
	@echo "    ${G}publicar${N}        Publica el cambio para el paquete deb."
	@echo "    ${G}crear_deb${N}       Genera el paquete deb para huayra."
	@echo ""


iniciar:
	npm install --no-option
	./node_modules/bower/bin/bower install

dist: compilar

ejecutar_linux: 
	nw dist

ejecutar_mac:
	/Applications/nwjs.app/Contents/MacOS/nwjs dist

test_mac: ejecutar_mac

build: compilar

publicar:
	dch -i

crear_deb:
	dpkg-buildpackage -us -uc

compilar:
	./node_modules/ember-cli/bin/ember build

compilar_live:
	./node_modules/ember-cli/bin/ember build --watch

version:
	# patch || minor
	@bumpversion patch --current-version ${VERSION} package.json public/package.json Makefile --list
	make build
	@echo "Es recomendable escribir el comando que genera los tags y sube todo a github:"
	@echo ""
	@echo "make subir_version"

ver_sync: subir_version

subir_version:
	git commit -am 'release ${VERSION}'
	git tag '${VERSION}'
	git push
	git push --all
	git push --tags

actualizar_tema:
	@echo "${G}Actualizando el tema${N}"
	@rm -r -f master.zip
	@wget https://github.com/hugoruscitti/huayra-bootstrap-liso/archive/master.zip
	@unzip master.zip -d tmp_theme
	@rm -r -f public/libs
	@rm -r -f public/img
	@rm -r -f public/fonts
	@mv tmp_theme/huayra-bootstrap-liso-master/destino/libs public/
	@mv tmp_theme/huayra-bootstrap-liso-master/destino/img public/
	@mv tmp_theme/huayra-bootstrap-liso-master/destino/fonts public/
	@mv tmp_theme/huayra-bootstrap-liso-master/destino/huayra-bootstrap.css public/
	@rm -r -f master.zip
	@rm -r -f tmp_theme

log:
	git log ${VERSION}...HEAD --graph --oneline --decorate

.PHONY: dist
