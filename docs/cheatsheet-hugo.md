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
