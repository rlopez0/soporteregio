#!/bin/bash

# Pedir el título como argumento
TITLE="$1"

# Validar que haya título
if [ -z "$TITLE" ]; then
  echo "[ERROR] Debes proporcionar un título para el post."
  echo "Uso: ./newpost.sh \"Mi título bonito\""
  exit 1
fi

# Crear el slug: minúsculas, reemplazos básicos
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g' -e 's/á/a/g' -e 's/é/e/g' -e 's/í/i/g' -e 's/ó/o/g' -e 's/ú/u/g' -e 's/ñ/n/g')

# Ruta donde se va a crear
PATH_POST="posts/$SLUG.md"

echo "[INFO] Generando post con Hugo..."
hugo new "$PATH_POST"

FULL_PATH="content/$PATH_POST"
echo "[OK] Post generado en: $FULL_PATH"

# Tratar de abrirlo automáticamente
if command -v cursor &> /dev/null; then
  cursor "$FULL_PATH"
elif command -v codium &> /dev/null; then
  codium "$FULL_PATH"
elif command -v code &> /dev/null; then
  code "$FULL_PATH"
else
  echo "[INFO] Editor no encontrado automáticamente. Abre el archivo manualmente: $FULL_PATH"
fi