param (
  [string]$Title
)

$Slug = $Title.ToLower().Replace(" ", "-").Replace("á", "a").Replace("é", "e").Replace("í", "i").Replace("ó", "o").Replace("ú", "u").Replace("ñ", "n")
$Path = "posts/$Slug.md"

Write-Host "[INFO] Generando post con Hugo..."
hugo new $Path

$FullPath = "content/posts/$Slug.md"
Write-Host "[OK] Post generado en: $FullPath"

# Abrirlo con VS Code automáticamente (si está instalado)
# Comprueba si existe el comando antes de ejecutarlo
#if (Get-Command "code" -ErrorAction SilentlyContinue) {
#    code $FullPath
#} elseif (Get-Command "code-insiders" -ErrorAction SilentlyContinue) {
#    code-insiders $FullPath
#} elseif (Get-Command "codium" -ErrorAction SilentlyContinue) {
#    codium $FullPath
#} else {
#    Write-Host "[INFO] Editor VS Code/Codium no encontrado. Abre el archivo manualmente."
#}