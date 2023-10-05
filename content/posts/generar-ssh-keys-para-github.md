+++
title = 'Generar Ssh Keys Para Github'
description = 'Como generar una key ssh para poner conectar con github desde el ordenar.'
date = 2023-10-05T10:55:01+02:00
draft = true
tags = ['man','git']
ShowReadingTime = true
+++

Como generar una key ssh para poner conectar con github desde el ordenar. 


A continuación voy a redactar una guia a modo de recordatoria personal, para cuando tenga que hacerlo, pero aqui os deja la guia completa dodne lo aprendí [Setting up git - The Odin Project](https://www.theodinproject.com/lessons/foundations-setting-up-git)


## instalar git y configurarlo

Instalar git, parece obvio pero muchas veces no esta instalada

```bash
git config --global user.name "Your Name"
git config --global user.email "yourname@example.com"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false
```



## creando ssh key

```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

Saltaran algunos prompts pidiendo el nombre de la llave, donde se guarde, etc. Le podeis a dar a todo aceptar sin poner nada, aunque recomiendo darle un numbre a la llave asi tenerla mas controlada. 

Por defecto las llaves se almacenan en '~/.ssh/'

En este punto hay que copiar la llave publica, para darsela a Github. 

```bash
cat ~/.ssh/id_ed25519.pub
# en caso de haberle puesto un nombre
cat ~/.ssh/<nombre_key>.pub
# podeis revisar todas las claves. 
ls $/.ssh/ 
```

Si le habeis dado a todo que si, aqui teneis la llave para copiar y pegar.  En mi caso la he llamado 'github_key'.



Copiamos toda la llave, algo com esto:

```bash
ssh-ed25519 AAAAC3NzaC1lZDIchurromuygrandeZHAEx6spnBoO7zeuCF+NWb0BI vuestro@email.com
```


## configurando la clave en github

En github.com, vais a vuestro perfil os vais a ajustes/settings y en la barra lateral izquierda os vais a SSH and GPG keys.

Creais un nueva clave SSH:

- Titulo, el nombre identificado de la clave, yo uso un nombre que me ayude a saber el ordenador o maquina virtual que es.
- Key type, no lo tocamos, por defecto "Authentication key"
- Key, le pegamos el contenido anterior. 


## comprobando que funcione

Podeis seguir [esta guia de Github para testear la conexion SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection) o podeis seguir los comando resumidos que os muestro.


```shell
ssh -T git@github.com
```

Typeamos 'yes'  para confirmar la conexion. y si todo va bien deberiamos de ver algo como esto:

```shell
> The authenticity of host 'github.com (IP ADDRESS)' can't be established.
> ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
> Are you sure you want to continue connecting (yes/no)?
```


## breve explicación sobre las claves

Basicamente cuando generas una clave estas generando dos archivos, o dos contraseñas, una publica y una privada. A github le estas dando la publica para que el compruebe contigo y tu puedas resolver con tu clave privada. Si esto sucede, tienes acceso. 


En caso de que existan errores o puedes revisar las guias que enlace en el articulo o escribir en los comentarios. 


## errores comunes

- [Github Error Permission denied (publickey)](https://docs.github.com/en/authentication/troubleshooting-ssh/error-permission-denied-publickey)

```shell
ssh -T git@github.com
#respuesta
git@github.com: Permission denied (publickey).
```

Si le habeis puesto un nombre espefico a vuestra key, es normal que tengais este fallo, y podeis debugear de esta forma:

```bash
ssh -vT git@github.com
```

En mi caso, en las últimas lineas me daba este error:

```bash
debug1: Trying private key: /home/jade/.ssh/id_rsa
debug1: Trying private key: /home/jade/.ssh/id_ecdsa
debug1: Trying private key: /home/jade/.ssh/id_ecdsa_sk
debug1: Trying private key: /home/jade/.ssh/id_ed25519
debug1: Trying private key: /home/jade/.ssh/id_ed25519_sk
debug1: Trying private key: /home/jade/.ssh/id_xmss
debug1: Trying private key: /home/jade/.ssh/id_dsa
debug1: No more authentication methods to try.
git@github.com: Permission denied (publickey).
```

Conclusion, github intenta acceder a unas claves por nombre genericos y tengo que indicarle que las mias estan en otro lado.

Os dejo esta guia donde viene explicado al detalle:

- [Usar multiples keys ssh](https://gist.github.com/aprilmintacpineda/f101bf5fd34f1e6664497cf4b9b9345f)

Tenemos que crear un nuevo archivo conf en ~/.ssh de esta forma

```bash 
nano ~/.ssh/config

#########
# En el archivo podeis algo tal que así
Host gh_personal
	HostName github.com
	IdentityFile ~/.ssh/<nombre-ssh-key-privada>
```

Para conectar: 

```bash
ssh -T git@gh_personal
```

Para simplicar en mi configuración y como no tengo necesidad de usar varias clave, voy a rehacerlo para que los nombres sean los genericos. 