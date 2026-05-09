---
title: "Terminal Macbuntu"
date: "2026-05-08T13:15:25-06:00"
# weight: 1
# aliases: ["/first"]
tags: ["terminal","macos","mac","personalización","ubntu","style"]
author: "El Admin"
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: true
description: ""
canonicalURL: "https://canonical.url/to/page"
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
    image: "terminal_portada.webp" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: true # when using page bundles set this to true
    hidden: true # only hide on current single page
#editPost:
#    URL: "https://github.com/<path_to_repo>/content"
#    Text: "Suggest Changes" # edit text
#    appendFilePath: true # to append file path to Edit link
---

# Terminal MacBuntu?

{{< figure src="terminal_full.webp" link="terminal_full.webp" target="_blank"
  rel="noopener noreferrer" width="980" height="600" align=center alt="iterm2 Ubuntu themed" caption="Terminal macOS Ubuntu Styled" >}}

Bueno pues, así como se lee un ¿MacBuntu? que es? una Mac con la distribución de Ubuntu? o Ubuntu con tematica de macOS...? 

Pues nada de eso, resulta ser que como Linuxero que soy, pero imposibilitado de usar Linux en mi [**día a día**]({{< relref "posts/linux-vs-empresas.md" >}}), siempre me ha gustado (~~gusto culposo~~) la tematica o estilo visual de la terminal de Ubuntu, entonces en este entredicho me puse a la tarea de emularlo lo mas que pueda.

## Contexto
Yo venía trabajando ya con una terminal llamada <a href="https://coreshell.app/" target="_blank" rel="noopener noreferrer">CoreShell</a> que es una terminal de terminales, muy poderosa la verdad, te permite hacer muchas configuraciones, tener tus sesiones grabadas, pero esta limitada en cuestion de paleta de colores y personalización un poco ya mas de vista o estilo, aunque de manera técnica es muy poderosa. Aún la conservo.

Y ya aquí tenía configurado una capa de personalización visual llamado <a href="https://ohmyz.sh/" target="_blank" rel="noopener noreferrer">#OhMyZSH!</a> o #OHZ, con el tema llamado <a href="https://github.com/romkatv/powerlevel10k" target="_blank" rel="noopener noreferrer">pk10 o powerlevel10k</a> y funciona muy bien, buena integración, fácil, rápido.

Depués le comencé a medio tunear mi ```.zsrh.rc``` agregando cositas como el <a href="https://github.com/fastfetch-cli/fastfetch" target="_blank" rel="noopener noreferrer">```fastfetch```</a>al arrancar la terminal y después le agregué unos ```ÀSCII``` randoms con color scripts por ejemplo:

Haciendo un:
{{< Terminal title="iTerm2" >}}
$ colorscript -e tiefighter1
{{< /Terminal >}}

El resultado será:

{{< figure src="tiefighter1.webp" link="tiefighter1.webp" target="_blank" rel="noopener noreferrer" align=center alt="tiefighter1" caption="Tiefighter en terminal" >}}

También comencé a agregar unos `aliases`.

## El comienzo
Para este primer paso lo mas básico y escencial es tener una terminal bastante robusta así como muy personalizable, después de buscar y probar me quedé con La terminal que uso es <a href="https://iterm2.com/" target="_blank" rel="noopener noreferrer">iTerm2</a>. Ya sé que va a sonar a chiste pero realmente es muy robusta y personalizable. Comencé por cambiarle el nombre del perfil *default* a **Ubuntu**.

Para **"emular"** mas la terminal de Ubuntu, por lo que cambié completamente la paleta de colores en <a href="https://iterm2.com/" target="_blank" rel="noopener noreferrer">iTerm2</a>:

* Fondo morado oscuro tipo Ubuntu
* Colores ANSI ajustados manualmente
* Verde más brillante (para comandos)
* Rojo más visible (para errores)

💡 Tip importante:
Subí el Minimum Contrast en iTerm2 para que los colores no se vean “lavados”.

Transparencia y Blur

Se veía bien pero al final lo dejé en `0`
{{< Terminal title="iTerm2" >}}
Transparencia: 0
Blur: 0
{{< /Terminal >}}

Fuente

Esto es básico le configuré la <a href="https://www.nerdfonts.com/font-downloads" target="_blank" rel="noopener noreferrer">MesloLGS Nerd Font</a>

¿Por qué?

* Compatible con Powerlevel10k
* Soporta iconos
* Se ve limpio

Herramientas <a href="https://www.reddit.com/r/gamedev/comments/ijhtxs/what_exactly_is_a_qol_improvement/?tl=es-419" target="_blank" rel="noopener noreferrer">QoS</a>

🔥 eza (mejor que un 'ls')

{{< Terminal title="iTerm2" >}}
ls -> eza --icons
{{< /Terminal >}}

🔥 bat (mejor que un 'cat')

{{< Terminal title="iTerm2" >}}
cat archivo.txt → bat archivo.txt
{{< /Terminal >}}

🔥 zoxide - Te lleva directo a rutas frecuentes.

{{< Terminal title="iTerm2" >}}
z pro
{{< /Terminal >}}

🔥 fzf - Te lleva directo a rutas frecuentes.

{{< Terminal title="iTerm2" >}}
CTRL + R
{{< /Terminal >}}

## La Ingeniería

Después de todo lo que estaba personalizando, cambiando y jugeteando, me dije a mi mismo:

**"Y si ya mejor me hagos mis dotfiles?"**

Entonces me puse manos a la obra...

Al final generé mi `terminal-dotfiles`, con los sigueintes perfiles

Los perfiles definen qué tan invasiva puede ser la personalización de terminal según el tipo de máquina.

### personal-full

El uso del `personal-full` en máquinas donde tienes control completo:

- Mac personal.
- VPS personales.
- Servidores de homelab.

En este perfil se permite instalar paquetes y activar herramientas de experiencia de terminal como `zsh`, `p10k`, `eza`, `bat`, `zoxide`, `fzf`, `fastfetch` y `colorscript`.

### lab-safe

El uso del `lab-safe` en entornos temporales:

- VMs de práctica.
- Laboratorios.
- Máquinas de prueba.

Este perfil permite personalización moderada. Puede usar `bash` o `zsh`, aliases seguros y utilerías opcionales cuando ya existen en el sistema.

La intención es mejorar la comodidad sin asumir que la VM será permanente ni modificar demasiado el entorno base.

### work-minimal

El uso de `work-minimal` en servidores de trabajo, servidores productivos o cualquier entorno donde convenga reducir riesgo y sorpresa.

Este perfil no instala paquetes porque en ambientes productivos el inventario de software, las dependencias y los cambios del sistema suelen estar controlados por políticas, automatización o equipos externos. Instalar herramientas manualmente puede romper expectativas operativas, auditoría o soporte.

Solo se permiten cambios mínimos por usuario:

- Prompt simple con color.
- Aliases seguros.
- Exports básicos.

La meta es tener una shell cómoda sin modificar el sistema ni introducir dependencias externas.

#### ⚠️ OJO 👀: Todos estos perfiles y personalizaciones de terminal NO cambian la terminal par que se vea tipo "**Ubuntu**" solo es para configurar aliases y herramientas para un trabajo mas fluido, rápido y sobre todo de asistencia para brindar comodidad.

Todo esto esta disponible en mi repositorio personal en Github <a href="https://github.com/rlopez0/terminal-dotfiles" target="_blank" rel="noopener noreferrer">terminal-dotfiles</a>