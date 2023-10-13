+++
title = 'Empezando Homelab Project'
date = 2023-10-13T14:07:23+02:00
draft = false
tags = ['homelab']
ShowReadingTime = true
+++

## En primer lugar, ¿que es un homelab?

Un homelab es un entorno de laboratorio tecnológico que una persona crea en su hogar, compuesto por hardware y software, con el propósito de aprender, experimentar y desarrollar habilidades en áreas como la informática, redes y seguridad. Puede incluir servidores, dispositivos de red y otros componentes configurados para la práctica y la experimentación, lo que lo convierte en una herramienta valiosa para el aprendizaje y la preparación en tecnología de la información.

## Configuración inicial y proposito

Revisando videos en youtube y canales de homelab por internet, podemos encontrar que hay autenticas locuras y gente que tiene montado autenticos servidores profesionales.

![Ejemplo de homelabs](/img/ejemplo-homelab-google.png)

En mi caso, no es que no quiera tanto, pero ni tengo especio ni tengo esa necesidad, al menos por ahora.

Mi objetivo con esto es aprender, experimentar y bueno, si mientras tanto puedo desarrollar algo que mejore mi entrenimiento y/o seguridad en el hogar, pues mejor.

### Configuración hardware-software

En mi caso cuanto con un nuevo pc de sobremesa que usaré para tal proposito.

- Host OS: Arch Linux
- Host hardware:
  - CPU: Intel i5 13500 14 nucleos
  - RAM: 32gb ram ddr5 6000mhz
  - SSD: 1TB

Configuraré una maquina virtual a través de KVM donde instalaré [Proxmox](https://www.proxmox.com/en/) que es un sistema operativo basado en debian especialziado en la creación y manejo de maquinas virtuales y contenedores.

Esta maquina virtual tendrá los siguientes recursos:

- CPU: 6 cores
- RAM: 8 Gb
- SSD: 50 Gb

## Servicios / aplicaciones

Mi idea inicial es instalar estos servicios:

- [Plex](https://www.plex.tv/), servicio para ver peliculas y series en casa. #entretenimiento
- [Wazuh](https://wazuh.com/), una solución XDR/SIEM tools. #ciberseguridad
- [Truenas](https://www.truenas.com/) o similar.
- [Pi-hole](https://pi-hole.net/), servidor dns.
- [pfsense](https://www.pfsense.org/) o [opnsense](https://opnsense.org/), solución de firewall.
- Servidor [nginx](https://www.nginx.com/) para alojar páginas web.
- Ordenador secundario, la idea es instalar una maquina virtual a la que puedan conectarle un monitor, teclado y raton para usarse a modo home-pc.
- [Home Assistant](https://www.home-assistant.io/) para controlar la domotica de casa.
- etc. cualquier idea que se me venga a la mente.

Otras ideas:

- Instalar [Nebula](https://github.com/slackhq/nebula) o [TailScale](https://tailscale.com/use-cases/homelab/) como solución VPN para acceder al home lab desde fuera.
- En el futuro, tener un servidor dedicado con proxmox corriendo estos servicios.

Esto es todo por hoy, si tienes alguna idea puedes dejarlo en la nueva sección de comentarios.

## Dudas y preguntas

En esta sección voy haciendo preguntas y dudas sobre la marcha que intentaré ir resolviendo poco a poco, algunas pueden ser de concepto, otras mas concretas y otras simples ideas que surgen de mi experiencia en el que estoy trabajando.

- KVM solo me ha permitido asignar 50Gb de espacio a la maquina virtual proxmox, ¿por que? Investigar como tener un partición del disco para que proxmox la use en exclusiva.
- Interfaces de red y enrutamiento desde el host hacia la maquina virtual. Investigar.
- Particion dedicada para proxmox.
