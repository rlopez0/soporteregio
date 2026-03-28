---
title: "Config Windows Docker"
date: "2025-04-24T10:20:21-06:00"
# weight: 1
# aliases: ["/first"]
tags: ["docker", "windows", "fedora", "contenedores", "devops"]
author: "El Admin"
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: true
description: "Lo prometido es deuda, configurando y corriendo Windows en Docker"
canonicalURL: "https://soporteregio.com/posts/config-windows-docker/"
disableHLJS: true # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: "/images/docker-windows.png" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
#editPost:
#    URL: "https://github.com/<path_to_repo>/content"
#    Text: "Suggest Changes" # edit text
#    appendFilePath: true # to append file path to Edit link
---
![Docker Windows](/images/docker-windows_500x500.png#center)
# 🪟🐳 ¡Levantando Windows en Docker como todo un hacker moderno!  
*— Fedora 42, contenedores y magia negra incluida*

> Sí, ya sé lo que estás pensando: "¿Windows en Docker? ¡¿En Linux?!". Y sí, también pensé que eso era como freír tacos en un microondas... pero mira, ¡funciona!

## 🔧 El chisme completo

Hace unos meses, me topé con un proyecto que parecía salido de una película de ciencia ficción: [`dockur/windows`](https://github.com/dockur/windows). Básicamente, te permite correr un Windows *completito* en un contenedor Docker, usando una imagen ultra liviana (ish...) que no se quiebra al primer pantallazo azul. ¡Bastante ingenioso la verdad!

Como buen curioso profesional, armé una **VM con Fedora 42**, le instalé Docker y me lancé a la aventura.

## 🚀 Paso a paso, sin que explote nada (~~spoiler: explotó poquito~~)

### 1. Montando la VM

Primero, Fedora 42. ¿Por qué Fedora? Porque está fresquecito, lo quería probar de pasada y para variar un poco con respecto a Ubuntu.  

Docker se instala fácil:
```bash
sudo dnf install -y docker
sudo systemctl enable --now docker
```

Pro tip: agrégate al grupo `docker` si no quieres estar usando **`sudo`** como si fuera muletilla de TikTok.
```bash
sudo usermod -aG docker $USER
newgrp docker <- esto es para que entre en caliente el nuevo grupo asignado si no vas a tener que salir de la terminal y volver a entrar. ;)
```

### 2. Clonando el proyecto dockur/windows
```bash
git clone https://github.com/dockur/windows.git
cd windows
```
Todo bien hasta aquí... Luego me sentí como Tony Stark viendo la interfaz porque hay tantas opciones de despliegue, pero tranqui, elegí la básica para no volarme el SSD.
Una vez descargado el repositorio hay 2 maneras de levantar el contenedor directo en línea con `docker run` o como a mi mas me gusta hacerlo mediante `docker compose` así que pondré el archivo `yaml` que utilicé para levnatar el Windows.

Por defecto si ponemos si lo le ponemos lo parametros que señalo en el archivo la VM "nace" con 8GB de RAM, 2 vCPUs y 64GB de HDD, pero nosotros podemos setearle mas a detalle personalización con en mi caso que agreugé usuario y contraseña así como definí la memoria en 4GB por la VM que estaba utilizando de pruebas.

Mas parámetros se pueden ver directamente en el repositorio del desarrollador.

```yaml
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "11"
      RAM_SIZE: "4G" # Agregué el parámetro y le puse 4GB en vez de 8 default
      USERNAME: "admin" # Agregué el parámetro con usuario definido el default es Docker
      PASSWORD: "admin" # Agregué el parámetro con usuario definido el default es admin, pero lo puse como quiera
      REGION: "en-US" # Agregué la región (idioma)
      KEYBOARD: "es-MX" # Agregué el tipo de teclado para español.
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    volumes:
      - /home/riky/docker/windows:/storage # Por defecto el almacenamiento se crea en ./windows, pero yo le di la ruta para que se colocará en donde arranque el contenedor.
    restart: always
    stop_grace_period: 2m
```
Hay mas opciones que se pueden agregar como definir una red, agregar mas volumenes (discos), cambiar la versión de Windows, etc pero esos se pueden consultar directamente en el [README.md](https://github.com/dockur/windows/blob/master/readme.md)

### 3. Levantando el contenedor
Para levantar el contenedor simplemente ubicados en la carpeta donde este el archivo docker-compose.yaml, ehecutamos:

```bash
docker compose up -d
```
¡Boom! Después de unos cuantos MBs y un café más tarde, mi contenedor Windows estaba corriendo. Y sí, con escritorio y todo, se puede ver el proceso de instalación directamente en el navegador web ingresando `http://127.0.0.1:8006` solo se recomienda utilizar este acceso para ver el progreso de instalación totalmente automático. una vez que termine e ingrese a la sesión recomiendo se accese vía RDP, para windows con el remote desktop es mas que suficiente, para Linux se puede usar remmina, y para MacOS se puede usar igualmente remmina o cualquier cliente RDP.
También ingresamos la dirección localhost y el puerto `127.0.0.1:8006`

### 4. Probando el sistema
Me conecté con un cliente VNC como si nada, y ahí estaba… Windows corriendo dentro de Docker, dentro de Fedora, dentro de una VM, dentro de mi PC. Me sentí como en Inception versión DevOps.

> Para ingresar al **Windows** recomiendo se accese vía **RDP**, para windows con el remote desktop es mas que suficiente, para Linux se puede usar **remmina**, y para MacOS se puede usar igualmente remmina o cualquier cliente RDP.
>> _También ingresamos la dirección localhost y el puerto -> `127.0.0.1:8006`_

## 🤓 ¿Vale la pena?
Si eres curioso, sí. Si eres masoquista, también... naaa no es tan complejo. ¿Es práctico para producción? Rotundo NO... ¿Pero para presumirle a tu compa el sysadmin? ¡Definitivamente sí!

También puede servir para levantar un windows muy rápido para pruebas simples, labs, testear algo, es mas, hasta para tirar uno que otro virusillo o malware, ver su comportamiento para un análisis mas afondo. Que se yo! puede servir para muchas cosas mientras tengas imaginación el cielo es el límite.

## 📸 Capturas y video
Aquí dejo unas fotitos del proceso para que veas que no te estoy choreando. Si quieres el paso a paso con video, coméntalo abajo o mándame un mensaje con una pizza y lo armo.

- yaml utilizado
[![yaml](/images/dw-yaml.png)](/images/dw-yaml.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Ejecución del contenedor
[![docker Compose](/images/dw-run.png)](/images/dw-run.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Ejecución completada, contenedor corriendo, comienza a descargar imagen.

[![docker Compose 2](/images/dw-run2.png)](/images/dw-run2.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Descarga del ISO de Windows

[![docker Windows Download](/images/dw-windownload.png)](/images/dw-windownload.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Instalación del Windows

[![docker Windows Install](/images/dw-wininstall.png)](/images/dw-wininstall.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Listo, así se ve terminado ya en el desktop sin interacción humana, cuenta local con red. Esto todavía es por la interfaz web. (No recomendable)

[![docker Windows Desktop Web](/images/dw-win_desktop_web.png)](/images/dw-win_desktop_web.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---
- Y así se ve ya conectado a windows desde Remmina en Fedora 42, chulada!

[![docker Windows Desktop Remmina](/images/dw-win_fullDesktop.png)](/images/dw-win_fullDesktop.png)
<small><em>Da clic en la imagen para verla en su tamaño original</em></small>

---

## 🧠 Conclusión filosófica
Docker es como el aguacate: le puedes poner a todo, y aunque a veces no tenga sentido, sabe bien. Así que si hoy quieres sentirte como un brujo digital, échate este proyectito y sorprende a todos diciendo:
# "Yo corrí Windows... ¡en un contenedor Linux!". 

Nos vemos en el próximo experimento loco,

— El Admin