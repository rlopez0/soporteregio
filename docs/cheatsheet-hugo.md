# Hugo Cheat Sheet - Soporteregio

Guía rápida para crear, editar y publicar contenido en el blog Soporteregio usando Hugo.

---

## Ubicación del proyecto

```bash
cd ~/Documents/DevProjects/sr_site/soporteregio
```

---

## Ver estado del repositorio

```bash
git status
```

---

## Ver rama actual

```bash
git branch --show-current
```

Normalmente la rama principal es:

```text
production
```

---

## Crear un nuevo post

```bash
hugo new content/posts/nombre-del-post.md
```

Ejemplo:

```bash
hugo new content/posts/mi-primer-post.md
```

---

## Editar contenido

Abrir todo el proyecto en VSCodium:

```bash
codium .
```

---

## Imágenes en posts

Convención recomendada para Soporteregio:

- Usar `{{< figure >}}` como formato por defecto para casi todas las imágenes
- Usar Markdown simple solo para imágenes pequeñas o inline dentro de un párrafo

### Opción recomendada: shortcode `figure`

Úsalo cuando quieras:

- centrar la imagen
- controlar ancho o alto
- agregar texto `alt`
- agregar `caption`
- hacer clic en la imagen para abrirla en grande

Ejemplo base:

```md
{{< figure
  src="/images/nombre-imagen.webp"
  alt="Descripción breve y útil"
  align=center
  width="800"
>}}
```

Ejemplo con caption:

```md
{{< figure
  src="/images/nombre-imagen.webp"
  alt="Descripción breve y útil"
  caption="Texto opcional para la imagen"
  align=center
  width="800"
>}}
```

Ejemplo clickeable para ampliar en la misma pestaña:

```md
{{< figure
  src="/images/nombre-imagen.webp"
  link="/images/nombre-imagen.webp"
  alt="Descripción breve y útil"
  caption="Haz clic para ampliar"
  align=center
  width="800"
>}}
```

Ejemplo clickeable para abrir en otra pestaña:

```md
{{< figure
  src="/images/nombre-imagen.webp"
  link="/images/nombre-imagen.webp"
  target="_blank"
  rel="noopener noreferrer"
  alt="Descripción breve y útil"
  caption="Haz clic para abrir la imagen"
  align=center
  width="800"
>}}
```

Notas:

- `link` hace que la imagen sea clickeable
- `target="_blank"` la abre en otra pestaña
- `rel="noopener noreferrer"` es buena práctica de seguridad
- normalmente basta con definir `width`
- usar `caption` solo cuando aporte contexto
- poner `alt` siempre que sea posible

### Opción simple: Markdown tradicional

Úsalo solo si no necesitas caption, alineación especial ni control fino del tamaño.

Imagen simple:

```md
![Descripción breve](/images/nombre-imagen.webp)
```

Imagen clickeable:

```md
[![Descripción breve](/images/nombre-imagen.webp)](/images/nombre-imagen.webp)
```

### Nota para bundles de página

Si el post usa bundle, por ejemplo `content/posts/macbuntu/index.md`, puedes usar rutas relativas:

```md
{{< figure
  src="terminal_full.webp"
  link="terminal_full.webp"
  alt="Terminal macOS Ubuntu themed"
  caption="Terminal macOS Ubuntu Styled"
  align=center
  width="980"
>}}
```

---

## Enlaces internos y externos

Convención recomendada para Soporteregio:

- enlaces internos del blog: abrir en la misma pestaña
- enlaces externos: abrir en otra pestaña para no sacar al lector del sitio

### Enlace interno

Usar Markdown normal o `relref` cuando aplique.

Ejemplo simple:

```md
[Ver otro post](/posts/linux-vs-empresas/)
```

Ejemplo con `relref`:

```md
[día a día]({{< relref "posts/linux-vs-empresas.md" >}})
```

### Enlace externo

Para enlaces externos, usar HTML para poder controlar que abra en otra pestaña.

Ejemplo:

```html
<a href="https://iterm2.com/" target="_blank" rel="noopener noreferrer">iTerm2</a>
```

Ejemplo dentro de un párrafo Markdown:

```md
La terminal que uso es <a href="https://iterm2.com/" target="_blank" rel="noopener noreferrer">iTerm2</a>.
```

Notas:

- `target="_blank"` abre el enlace en otra pestaña
- `rel="noopener noreferrer"` es buena práctica de seguridad
- para enlaces internos no hace falta usar `target="_blank"`

---

## Terminal estilo macOS

Si quieres mostrar comandos como ventana tipo iTerm2/macOS, usar el shortcode `Terminal`.

Ejemplo:

```md
{{< Terminal title="iTerm2" >}}
$ colorscript -e tiefighter1
$ fastfetch
{{< /Terminal >}}
```

Notas:

- `title` es opcional
- el contenido se escribe tal cual dentro del shortcode
- esto se recomienda cuando quieras un bloque más visual que un simple bloque ```bash

---

## Portada de posts (`cover`)

La portada del frontmatter se usa para la imagen de vista previa del post. En Soporteregio ya quedó estandarizada para verse con la misma proporción visual en listas y home, aunque la imagen original tenga otro tamaño.

Ejemplo:

```yaml
cover:
  image: "/images/mi-portada.webp"
  alt: "Descripción breve"
  caption: "Texto opcional"
  relative: false
  hidden: true
```

Si la portada vive dentro de la misma carpeta del post, por ejemplo en un page bundle como `content/posts/macbuntu/index.md`, usa:

```yaml
cover:
  image: "terminal_portada.webp"
  alt: "MacBuntu cover"
  caption: "Texto opcional"
  relative: true
  hidden: true
```

Notas:

- en listados, todas las portadas se recortan de forma uniforme para mantener simetría
- conviene preparar imágenes horizontales
- una proporción recomendada es `16:9`
- un tamaño base práctico puede ser `1600x900`
- `hidden: true` en tu configuración actual oculta la portada dentro del post individual, pero la sigue mostrando en home y listas

---

## Importante: publicar el post

En el archivo Markdown, revisar este valor:

```yaml
draft: true
```

Cambiarlo a:

```yaml
draft: false
```

Si no haces esto, el post no se publica.

---

## Vista previa local

```bash
hugo server -D
```

Abrir en navegador:

```text
http://localhost:1313
```

Para detener el servidor:

```bash
Ctrl + C
```

---

## Generar sitio (build)

```bash
hugo
```

Esto genera la carpeta:

```text
public/
```

Esa carpeta normalmente no se sube al repo porque ya está ignorada en `.gitignore`.

---

## Publicar cambios con Git

### 1. Ver cambios

```bash
git status
```

### 2. Agregar cambios

```bash
git add .
```

### 3. Crear commit

```bash
git commit -m "Nuevo post sobre X tema"
```

### 4. Subir cambios

```bash
git push origin production
```

---

## Flujo completo rápido

```bash
cd ~/Documents/DevProjects/sr_site/soporteregio

hugo new content/posts/nuevo-post.md
codium .

hugo server -D
# editar contenido y revisar en navegador

git add .
git commit -m "Nuevo post"
git push origin production
```

---

## Buenas prácticas

- Siempre revisar con `hugo server -D`
- Confirmar que el post tenga `draft: false`
- Usar mensajes claros en los commits
- No subir archivos basura como `.DS_Store`

---

## Archivos que no deben subirse

- `.DS_Store`
- `public/`
- `resources/`
- `*.log`
- `*.tmp`

---

## Comandos útiles

Ver versión de Hugo:

```bash
hugo version
```

Levantar servidor local:

```bash
hugo server -D
```

Generar build:

```bash
hugo
```

---

## Notas finales

- Hugo genera sitios estáticos, por eso es rápido y seguro.
- El deploy se hace automáticamente con GitHub Actions.
- Normalmente solo necesitas hacer `git push` a la rama correcta.
