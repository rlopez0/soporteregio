---
title: "Linux vs Empresas"
date: "2025-05-05T22:12:43-06:00"
# weight: 1
# aliases: ["/first"]
tags: ["apple","macos","linux","tecnología","windows"]
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
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: "/images/linux-vs-empresas1.png" # image path/url
    height: "250px" # limit image height
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
#editPost:
#    URL: "https://github.com/<path_to_repo>/content"
#    Text: "Suggest Changes" # edit text
#    appendFilePath: true # to append file path to Edit link
---
# Linux, te quiero… pero no puedo: cómo terminé en macOS sin traicionar mis principios

Desde hace años, he sido fan de Linux. Me encanta su filosofía, su eficiencia, la forma en que puedo controlar cada aspecto del sistema, y cómo se adapta perfectamente a servidores, labs, contenedores y todo lo que huela a DevOps. Usar `Core Shell`, configurar redes con `nmcli`, automatizar cosas con Bash o montar entornos con Ansible en Linux es simplemente una delicia. Pero hay una verdad que me costó aceptar: en mi día a día, **no he podido usarlo como sistema base**.

## Las barreras del mundo real

Linux es poderoso, sí. Pero el entorno en el que trabajo no siempre lo permite. Estas son algunas de las razones por las que, aunque lo adoro, no puedo casarme con él como sistema principal:

- **VPN corporativa** *¡Arrghh!* uno de los retos (que luego hablaré de ello en otro post) es el infierno que tuve que pasar para poder acceder a mis laboratorios y máquinas virtuales cuando tenía la VPN  corporativa encendida por temas del trabajo, tenía que desconectarme un momento conectarme a la PC o a otra VM y reconectrarme de nuevo a la VPN, esto debido a que redirige todo el tráfico y rompe redes locales.
- **Correo electrónico con Exchange on-premises**, dependiente de Outlook, y con políticas absurdamente cerradas, esto imposibilita en gran medida el flujo de trabajo o el dinamismo que se puede obtener simplemente entrando a cualquier interfaz web de gestión de correo y listo, pero no ese cancer de *Exchange*, hace todo mas difícil.
- **Compatibilidad con ciertos periféricos o servicios** (como firmadores digitales, clientes de video o ciertos formatos).

Todo eso hizo que usar Linux como sistema principal fuera una pelea constante, y no quiero que mi sistema operativo me frene... quiero que me potencie. ~~Simplemente no hay soporte para otros sistemas operativos que no sean Windows~~

## ¿Y entonces? Entra macOS al juego

Probé macOS sin muchas expectativas, pero la sorpresa fue grande. Para alguien como yo que vive en terminal, redes, contenedores y automatizaciones, **macOS se sintió como un Linux con esteroides y buen gusto**:

- Terminal poderosa, compatible con herramientas como `brew`, `docker`, `ssh`, `zsh`, etc.
- Basado en Unix, lo que hace que muchos comandos y comportamientos me resulten familiares.
- Excelente integración de hardware y software. Todo simplemente funciona. Sin batallar con drivers, resoluciones raras o glitches gráficos.
- Interfaz pulida, gestos multitáctiles y herramientas de productividad que fluyen.

Ahora bien por otro lado eh intentado tener en [*"dual-boot"*](https://es.wikipedia.org/wiki/Multiarranque) Windows y Linux, pero eso no funciona al final termino quitando la partición de Linux, reclamando ese espacio preciado para demas actividades en la PC. Eso si la PC es para jugar videojuegos eso ni Linux ni MacOS todavía estan a la par.

## No es traición, es evolución

Sigo usando Linux... en Proxmox (*otro tema para un siguiente post*), en servidores, en mis contenedores, en los labs para mis certificaciones. Ahí está donde brilla. Pero para el sistema base desde el cual gestiono todo, **macOS ha sido mi mejor elección hasta ahora**, siente que es tener lo mejor de 2 mundos, escritorio bonito, bien pulido como en Windows y el poder de la fluidez, libertad (con sus ***), potencia de la terminal, practicidad de uso, personalización "justa" como un Linux.

Y con cómo se está poniendo Windows últimamente (telemetría invasiva, rendimiento cuestionable, forzar hacer tener una cuenta de microsoft para iniciar sesión, y lo peor! **tratarte como a un niño**), tener algo estable, fluido y funcional como macOS se siente como un descanso.

## ¿Y el futuro?

Quizá algún día pueda usar Linux como sistema principal sin compromisos. O tal vez las empresas adopten más software open source y dejen de forzar Windows como único camino. Mientras tanto, encontré mi equilibrio: **Linux para lo técnico, macOS para el día a día**.

Así que no, no he abandonado a Linux. Solo lo puse en un lugar donde puede brillar sin fricciones.

{{< figure src="/images/linux-vs-empresas2.png" width="500" height="700" align=center alt="Tux and mac win" caption="A la basura con el mugrero" >}}

---

Si tú también estás en esta dualidad, cuéntame tu experiencia. ¿Has tenido que ceder ante las circunstancias? ¿Cuál ha sido tu solución?

¡Nos leemos en el siguiente post, con más hacks, historias y terminales abiertos! 😉
