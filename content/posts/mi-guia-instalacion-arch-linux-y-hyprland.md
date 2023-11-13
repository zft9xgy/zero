+++
title = 'Mi Guia Instalación Arch Linux Y Hyprland'
date = 2023-11-11T16:26:38+01:00
draft = true
tags = ['man','arch','hyprland']
ShowReadingTime = true
+++

Antes de empezar, un pequeño disclaimer:

Esto pretende ser una guía donde me explico a mi mismo como instalar Arch Linux y Hyprland con la configuración que tengo actualmente.

El motivo para hacer esto es que ya llevo un tiempo usando Arch con Hyprland como daily driver y he puesto tiempo y dedicación en conseguir una configuración que me gusta, y de la cual voy olvidando poco a poco que y como lo configuré. 

Esta guía pretende ser un salvavidas por si algún día tengo que volver a instalar Arch desde zero. 

La público porque espero pueda ayudarte a ti también.

En cada apartado listaré fuentes y recursos que he usado en cada fase, por si estos puedan ser de utilidad para el lector. La mayoría estarán en inglés.
## instalación de arch linux

Al final de la sección os dejo una lista con recursos y fuentes que he usado para documentarme y conseguir entender el proceso de instalación. 

Doy por hecho que ya tengo un usb booteable de Arch Linux, que fácilmente se puede hacer con balena etcher o rufus. Y también doy por hecho que se cuenta con EFI.

```sh
loadskeys es
setfont ter-132b
```

Compruebo la conexión a internet con:

```sh
ping -c 1 archlinux.org
```

Por ethernet no debería de tener problemas de conexión, de existir, deberás investigar porque nunca se me ha dado el caso.

Si es por wifi, es normal que no tengas internet porque no esta conectado, para conectar, usa`iwctl`

```sh
iwctl
# dentro de la consola de iwctl
device list
station NOMBRE_INTERFACE scan
station NOMBRE_INTERFACE get-networks
station NOMBRE_INTERFACE connect SSID
exit 
```

Ahora vamos a poneros en hora:

```sh
timedatectl
timedatectl set-timezone Europe/Madrid
timedatectl set-ntp true
```

Partición y formateo del disco, esto va depender del espacio que tengas y como quieras realizar la instalación. Usualmente instala el root y home en particiones diferentes, con ext4, pero no he visto ninguna ventaja o desventaja el hacerlo así todavía.  Por lo que para hacerlo simple recomiendo 3 particiones, root/home, efi y swao

Quiero probar `btrfs` y configurar el `snaper`, quizás tengas tiempo para probarlo e investigar un poco, te dejo un video de Ermanno [How to install Arch Linux with BTRFS & Snapper](https://www.youtube.com/watch?v=sm_fuBeaOqE)

Aviso para el lector, en el siguiente punto no deberías copiar y pegar porque deberás de adaptar la partición a tu disco. 

```sh
lsblk
# imagianndo que vas a usar el disco /dev/sda aunque podriar ser otro como /dev/nvme0n1 o mmcblk0
# sda1 efi 512MB
# sda2 swap algo entre 2gb y la mitad de la ram instalada
# sda3 root el restante de espacio 

# para crear las particiones, lo más sencillo es: cfdisk (gpt)
cfdisk
# efi -> 512 MB type -> EFI SYSTEM
# swap -> 2048MB type -> Linux swap
# root type -> Linux

# formateo
mkfs.ext4 /dev/_root_partition_
mkswap /dev/_swap_partition_
mkfs.fat -F 32 /dev/_efi_system_partition_

#montando las particiones
mount /dev/_root_partition_ /mnt
mount --mkdir /dev/_efi_system_partition_ /mnt/boot
swapon /dev/_swap_partition_

```

Antes de realizar con la descarga y entrar con pacman, recomiendo usar reflector para seleccionar el repositorio más rápido, ya que en ocasiones hay algunos repositorios que van a pedales.

```sh
pacman -Syy
pacman -S reflector
# hacer un backup de la lista por si acaso
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak 
reflector -c "ES" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

Instalando los paquetes esenciales en la montura:

```sh
pacstrap -K /mnt base linux linux-firmware nano base-devel
```

Generamos  las instrucciones de montaje para que las particiones se monten  cada vez que el sistema inicia.

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Ahora ya a lo que yo llamo la instalación propia de Arch, donde entramos al punto de montaje y empezamos a instalar cosas. 

```sh
arch-chroot /mnt
# set time
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc

# entrar en `/etc/locale.gen` y descomentar la linea `en_US.UTF-8`
# si quieres usar español descomenta la linea correspondiente
nano /etc/locale.gen
# despues de descomentar linea
locale-gen
echo 'LANG=_en_US.UTF-8_' > /etc/locale.conf

# establecer keymap en consola (nunca persiste, pero lo hago igualmente)
echo 'KEYMAP=es' > /etc/vconsole.conf

# network configuration
echo 'archpc' > /etc/hostname
touch /etc/hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	archpc" >> /etc/hosts

# Initramfs
mkinitcpio -P

# root and user
passwd

pacman -S sudo

useradd -m zft9zgy
passwd zft9zgy

usermod -aG wheel team

# descomentar la linea wheel=ALL(ALL:ALL) ALL
EDITOR=nano visudo

```

Install Grub bootloader

```sh
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/_efi_system_partition_ /boot/efi

# Some motherboards cannot handle bootloader-id with spaces in it.
# en ese caso usar --bootloader-id=GRUB
grub-install --target=x86_64-efi --bootloader-id="Arch Linux" --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg
```


Antes de reiniciar es muy importante que tengamos instalados todos los paquetes necesarios para la conexión a internet, ya que ahora mismo estamos en en el entorno de instalación y esta ok, pero cuando reiniciemos desaparece. También se van a instalar algunas librerias para el bluetooth.

```sh
pacman -Sy networkmanager dhcpcd wpa_supplicant bluez bluez-utils

systemctl enable NetworkManager
systemctl enable blueooth

```

instalar blueooth
instalar audio
instalr microcode intel
instalar paquetes de amd 
etc

```sh

```

```sh

```

```sh

```

```sh

```

### Fuentes y recursos:

- https://itsfoss.com/install-arch-linux/
- https://wiki.archlinux.org/title/installation_guide

Recomiendo la guía de instalación oficial de la wiki porque es muy completa, aunque para alguien que esta empezando puede ser abrumadora.


instalar yay
instalar blackarch
## instalación de paquetes básicos 

## instalando y configurando hyprland

## instalando  apps

## instalando homelab
