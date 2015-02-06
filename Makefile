VERSION=0.0.1
NOMBRE="TXT_NOMBRE"

N=[0m
G=[01;32m
Y=[01;33m
B=[01;34m

comandos:
	@echo ""
	@echo "${B}Comandos disponibles para ${G}TXT_NOMBRE${N}"
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
	@echo "  ${Y}Para distribuir${N}"
	@echo ""
	@echo "    ${G}version${N}         Genera una nueva versión."
	@echo "    ${G}subir_version${N}   Sube version generada al servidor."
	@echo "    ${G}publicar${N}        Publica el cambio para el paquete deb."
	@echo "    ${G}crear_deb${N}       Genera el paquete deb para huayra."
	@echo ""


iniciar:
	npm install
	bower install

ejecutar_linux:
	nw src

ejecutar_mac:
	/Applications/nwjs.app/Contents/MacOS/nwjs src

publicar:
	dch -i

crear_deb:
	pdebuild

compilar:
	ember build

compilar_live:
	ember build --watch

version:
	# patch || minor
	@bumpversion patch --current-version ${VERSION} package.json public/package.json Makefile --list
	make build
	@echo "Es recomendable escribir el comando que genera los tags y sube todo a github:"
	@echo ""
	@echo "make ver_sync"

subir_version:
	git commit -am 'release ${VERSION}'
	git tag '${VERSION}'
	git push
	git push --all
	git push --tags

.PHONY: dist
