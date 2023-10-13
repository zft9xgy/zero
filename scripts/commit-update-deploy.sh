#!/usr/bin/env bash
#
# Este script facilita el proceso de update y deploy con hugo.
#
#
# Pseudo codigo
# 1. Eliminar la carpeta public
# 2. Hugo realiza el nuevo build
# 3. Git add . & commmit & push
#
# se debe ejecutar desde el directoria base donde se encuentra hugo

cd $HOME/shared-across/zero
rm -rf ./public
hugo
git add .
git commit -m "Update content"
git push
