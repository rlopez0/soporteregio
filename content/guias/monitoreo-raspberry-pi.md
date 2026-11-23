+++
title = "¿Se cayó mi internet? Monitoreo con Raspberry Pi y UptimeRobot"
draft = false
date = 2026-11-23T17:08:09-06:00
tags = ["raspberry pi", "homelab", "monitoreo", "docker"]
+++

> Esta guía adapta una experiencia de mi homelab. Los nombres, dominios y credenciales son ficticios; los ejemplos deben revisarse antes de usarlos en un entorno propio.

## La idea

¿Cómo enterarme de que mi conexión de casa dejó de responder cuando estoy fuera? Una opción es colocar un pequeño servicio web en una Raspberry Pi y pedirle a un monitor externo que lo consulte periódicamente.

En mi laboratorio documenté una solución con estas piezas:

1. Una **Raspberry Pi** ejecuta un servicio web sencillo con Docker.
2. Un proveedor de **DNS dinámico**, como Dynu, mantiene actualizado un nombre cuando cambia la IP pública.
3. **UptimeRobot** consulta el servicio y avisa si deja de responder.

```text
Monitor externo → nombre DDNS → conexión de casa → Raspberry Pi → página de estado
```

### Qué demuestra —y qué no—

Si el monitor recibe una respuesta, sabemos que esa ruta hasta el servicio respondió en ese momento. Si falla, **no significa necesariamente que se cayó internet**: también podría fallar la Raspberry, el contenedor, el DNS, el router o la conexión desde el propio monitor. La alerta es el comienzo del diagnóstico.

## Lo que se necesita

- Una Raspberry Pi con Docker y Docker Compose.
- Una cuenta en un proveedor de DNS dinámico; en este ejemplo utilizo Dynu.
- Una cuenta en UptimeRobot o en otro servicio que compruebe una URL.
- Un mecanismo para que el monitor pueda alcanzar el servicio desde fuera de la red.

**Importante:** publicar un servicio doméstico en internet requiere revisar la configuración del router y del firewall. En algunas conexiones, por ejemplo detrás de CGNAT, el redireccionamiento de puertos puede no funcionar. En mi documentación original usé un puerto redirigido; otra alternativa para evaluar es un túnel. Cada opción tiene requisitos y consecuencias distintos.

## 1. Preparar el nombre dinámico

Crea un nombre en tu proveedor de DDNS. Para esta explicación usaré `estado.example.com`: es un dominio de ejemplo y no corresponde a mi red.

El componente DDNS comprueba la dirección pública y actualiza el registro cuando cambia. El proyecto [ddns-updater](https://github.com/qdm12/ddns-updater) admite varios proveedores, incluido Dynu; consulta su documentación para usar los campos y la versión adecuados para tu cuenta.

Una configuración **ilustrativa**, con valores inventados, tendría esta forma:

```json
{
  "settings": [
    {
      "provider": "dynu",
      "domain": "estado.example.com",
      "username": "USUARIO_DE_EJEMPLO",
      "password": "CREDENCIAL_DE_EJEMPLO"
    }
  ]
}
```

Guarda la configuración real fuera de repositorios públicos y evita pegar contraseñas o tokens en capturas y registros. Los campos exactos dependen del proveedor y de la versión del programa; este fragmento es una referencia, no un archivo listo para producción.

## 2. Levantar una página de estado

En mi guía utilicé un contenedor NGINX para servir una página pequeña. Este ejemplo muestra la idea con un archivo de texto local:

```bash
mkdir -p ~/monitoreo-web
printf 'Servicio de monitoreo disponible\n' > ~/monitoreo-web/index.html
```

Un ejemplo de Docker Compose para servir esa carpeta es:

```yaml
services:
  estado:
    image: nginx:alpine
    restart: unless-stopped
    ports:
      - "8080:80"
    volumes:
      - ./monitoreo-web:/usr/share/nginx/html:ro
```

Si guardas el archivo Compose en tu directorio personal, puedes iniciar el servicio y comprobarlo localmente con:

```bash
docker compose up -d
curl -i http://localhost:8080/
```

Aquí `8080` es solo un puerto de ejemplo. Esta comprobación local **no confirma** que el servicio sea accesible desde internet. Antes de usar estos comandos, revisa el archivo Compose, las rutas y los puertos de tu entorno.

## 3. Conectar el monitor externo

Configura el acceso externo elegido y crea un monitor HTTP o HTTPS en UptimeRobot. Como ejemplo conceptual, la URL podría ser `https://estado.example.com/`; usa HTTPS únicamente si configuraste un certificado válido para ese nombre.

Asocia una notificación y prueba tanto la respuesta normal como una interrupción controlada del servicio. UptimeRobot permite configurar los criterios de respuesta; revisa su [guía para crear un monitor](https://help.uptimerobot.com/en/articles/11358364-how-to-create-your-first-monitor-on-uptimerobot-quick-setup-guide) y las opciones disponibles en tu cuenta.

## Lo que me llevo de este laboratorio

Me gusta este enfoque porque separa el punto que se comprueba del lugar desde el que lo observo. Una alerta me dice que algo en la ruta dejó de responder; después toca revisar la Raspberry, el servicio, el DNS y la conexión para encontrar el motivo.

La versión que conservo en mi documentación privada incluye mis rutas y configuración particulares. Esta versión pública describe el patrón sin publicar los datos de mi red.

## Para seguir explorando

- [Proyecto ddns-updater](https://github.com/qdm12/ddns-updater)
- [Documentación de NGINX](https://nginx.org/en/docs/)
- [Guía de monitores de UptimeRobot](https://help.uptimerobot.com/en/articles/11358364-how-to-create-your-first-monitor-on-uptimerobot-quick-setup-guide)
