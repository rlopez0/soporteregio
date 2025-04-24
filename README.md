# 🧠 Soporteregio.com – Blog personal con Hugo + PaperMod

Este repositorio contiene el código fuente y la estructura del blog [Soporteregio.com](https://soporteregio.com), generado con Hugo y basado en el tema [PaperMod](https://adityatelange.github.io/hugo-PaperMod/).

## ⚙️ Flujo de trabajo automatizado

El flujo está pensado para facilitar el desarrollo desde tu PC con Windows (y Mac en el futuro), con scripts para:

- Crear nuevos posts
- Compilar el sitio localmente
- Publicar al VPS sin pasos manuales

---

## 📁 Estructura del proyecto

Soporteregio.com/ 
├── content/posts/ # Entradas del blog 
├── static/ # Recursos estáticos (imágenes, etc.) 
├── public/ # Sitio generado por Hugo (no editar a mano) 
├── scripts/ # Scripts de automatización 
│ ├── build.ps1 
│ ├── deploy.ps1 
│ └── newpost.ps1 
├── config.toml # Configuración del blog 
├── themes/ # Tema PaperMod 
└── README.md # Este archivo

---

## 🧰 Scripts disponibles

### 📝 1. Crear nuevo post

```powershell
.\scripts\newpost.ps1 "Mi título llamativo"
```
Esto genera un archivo .md con estructura base en content/posts/.

🔨 2. Compilar el sitio localmente
```powershell
.\scripts\build.ps1
```
Genera el contenido en la carpeta public/, listo para publicar.

🚀 3. Publicar al servidor VPS
```powershell
.\scripts\deploy.ps1
```
Este script hace lo siguiente:

- Genera el sitio con Hugo
- Usa pscp.exe de PuTTY + tu llave privada artemisa.ppk
- Sube el contenido al VPS (45.56.73.27) en la ruta /var/www/soporteregio.com

    ⚠️ Requiere que tengas instalado PuTTY y pscp.exe esté disponible en tu sistema.

---

🌿 Uso de ramas Git
Este proyecto utiliza un esquema clásico de ramas:

- production: rama activa que refleja el sitio en vivo
- development: cambios en progreso
- staging: pruebas antes de publicar

---

Flujo típico:

```bash
git checkout development
# haces cambios, creas posts...
git add .
git commit -m "nuevo contenido"
git push origin development

# cuando esté listo para producción:
git checkout production
git merge development
git push origin production

# y luego publicar al VPS
.\scripts\deploy.ps1
```
---
🔐 Acceso al servidor
- VPS: 45.56.73.27
- Usuario: ricardo (ajustar si cambia)
- Llave privada: C:\Users\goofy\.ssh\artemisa.ppk

---
Ruta de despliegue: /var/www/soporteregio.com

📌 Requisitos
- Hugo instalado en el sistema
- Git Bash o WSL (si usas rsync en el futuro)
- PuTTY + pscp.exe (compatible con .ppk)

---
📅 Pendientes a futuro
- Configurar GitHub Actions para despliegue automático
- Agregar CI para validar estructura del sitio antes de publicar
- Sincronización con Mac vía Syncthing o Git cuando esté reparada

---
👨🏻‍💻 Autor
rlopez0
Blog técnico personal sobre tecnología, Linux, IA y cosas ñoñas del mundo moderno 🤓
soporteregio.com

