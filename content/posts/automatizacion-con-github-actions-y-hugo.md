---
title: "Automatizacion Con Github Actions Y Hugo"
date: "2026-03-28T00:50:24-06:00"
# weight: 1
# aliases: ["/first"]
tags: ["hugo", "devops", "automatizacion", "linux"]
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
    image: "<image path/url>" # image path/url
    alt: "<alt text>" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: true # only hide on current single page
#editPost:
#    URL: "https://github.com/<path_to_repo>/content"
#    Text: "Suggest Changes" # edit text
#    appendFilePath: true # to append file path to Edit link
---

Después de meses sin escribir en el blog (sí, desde 2025 😅), por fin decidí arreglar algo que me daba mucha flojera: el proceso de publicación.

Antes era un caos:
- Generar el sitio manualmente
- Subir archivos al VPS
- Validar permisos
- Repetir si algo fallaba

Ahora todo eso se hace solo.

## ⚙️ ¿Qué hice?

Implementé un flujo automático usando:

- Hugo para generar el sitio
- GitHub Actions para automatizar el build
- rsync + SSH para desplegar al VPS

Cada vez que hago:

```bash
git push origin production