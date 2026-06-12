# SoporteRegio.com

Repositorio del sitio [soporteregio.com](https://soporteregio.com), generado con [Hugo](https://gohugo.io/) y basado en el tema [PaperMod](https://github.com/adityatelange/hugo-PaperMod/).

El proyecto funciona como blog técnico en español, con contenido sobre terminales, Linux, automatización, contenedores, Windows y herramientas de desarrollo.

## Stack actual

- Hugo Extended
- Tema PaperMod
- Markdown + shortcodes de Hugo
- GitHub Actions para build y deploy
- VPS remoto como destino de publicación

## Estructura principal

```text
soporteregio/
├── archetypes/                  # Plantillas base para nuevos posts
├── content/posts/               # Entradas del blog
├── docs/                        # Documentación interna del proyecto
├── layouts/                     # Overrides locales del tema y shortcodes
│   ├── partials/
│   └── shortcodes/
├── static/                      # Recursos públicos estáticos
├── themes/PaperMod/             # Tema base
├── config.yaml                  # Configuración principal del sitio
└── .github/workflows/deploy.yml # Pipeline de despliegue
```

## Convenciones del contenido

La documentación editorial del proyecto vive en:

- [docs/cheatsheet-hugo.md](docs/cheatsheet-hugo.md)

Ahí quedaron registradas las reglas actuales para:

- imágenes dentro de posts
- portadas (`cover`) en frontmatter
- enlaces internos y externos
- uso del shortcode `figure`
- uso del shortcode `Terminal`

## Shortcodes locales

Además de PaperMod, el sitio incluye shortcodes locales dentro de `layouts/shortcodes/`.

### `figure`

Versión local del shortcode para imágenes con soporte consistente para:

- `caption`
- `link`
- `target="_blank"`
- imágenes dentro de page bundles

### `Terminal`

Shortcode visual para mostrar comandos como ventana tipo macOS/iTerm2.

Ejemplo:

```md
{{< Terminal title="iTerm2" >}}
$ colorscript -e tiefighter1
{{< /Terminal >}}
```

## Portadas y estilo visual

El sitio incluye overrides propios para mantener consistencia visual respecto al tema base:

- ancho principal del layout ajustado desde `themes/PaperMod/assets/css/extended/custom.css`
- portadas de posts normalizadas para listas y home
- header local con rutas relativas para mejor comportamiento en desarrollo local
- soporte visual para bloques `Terminal`

## Desarrollo local

Vista previa local:

```bash
hugo server -D
```

Build completo:

```bash
hugo
```

## Despliegue

El despliegue está definido en:

- [.github/workflows/deploy.yml](.github/workflows/deploy.yml)

Flujo actual:

1. Push a la rama `production`
2. GitHub Actions ejecuta build con Hugo Extended
3. El contenido generado en `public/` se sincroniza al VPS mediante `rsync` sobre SSH

## Configuración relevante

Algunos puntos importantes de `config.yaml`:

- `baseURL: https://soporteregio.com`
- `theme: PaperMod`
- `defaultContentLanguage: es`
- `markup.goldmark.renderer.unsafe: true`
- `outputs.home` incluye `HTML`, `RSS` y `JSON`

## Estado actual del proyecto

El repositorio ya no depende del flujo descrito originalmente con scripts PowerShell para publicar. El proceso activo de build y despliegue está centrado en Hugo local para vista previa y GitHub Actions para publicación.