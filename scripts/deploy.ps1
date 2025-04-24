# nuevo-deploy.ps1
# Script para desplegar un sitio Hugo a un servidor remoto
# Version mejorada con manejo automático de permisos (rlopez:www-data → www-data:www-data)

$RemoteUser = "rlopez"
$RemoteIP = "45.56.73.27"
$RemotePort = "2222"
$RemotePath = "/var/www/html/soporteregio.com/public_html/"
$LocalPath = "D:\Proyecto Hosting\Soporteregio.com\soporteregio\public\"
$KeyPath = "$HOME\.ssh\artemisa"

# Verificar si OpenSSH está disponible
function Test-SshCommand {
    try {
        $null = Get-Command "ssh" -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Limpiar carpeta public antes de generar el sitio
Write-Host "[CLEAN] Eliminando carpeta public existente..." -ForegroundColor Cyan
if (Test-Path $LocalPath) {
    Remove-Item -Path $LocalPath -Recurse -Force
    Write-Host "[CLEAN] Carpeta public eliminada exitosamente." -ForegroundColor Green
} else {
    Write-Host "[CLEAN] La carpeta public no existia, se creara nueva." -ForegroundColor Yellow
}

# Generar el sitio
Write-Host "[BUILD] Generando el sitio..." -ForegroundColor Cyan
hugo

# Verificar si el sitio se generó correctamente
if (-not (Test-Path "$LocalPath\index.html")) {
    Write-Host "[ERROR] No se encontro index.html en $LocalPath. Esta configurada correctamente la ruta?" -ForegroundColor Red
    exit 1
}

# Información del despliegue
Write-Host ""
Write-Host "[IMPORTANTE] Este script utilizara la siguiente configuracion:" -ForegroundColor Yellow
Write-Host "  - Usuario: $RemoteUser" -ForegroundColor Yellow
Write-Host "  - Servidor: $RemoteIP" -ForegroundColor Yellow
Write-Host "  - Puerto: $RemotePort" -ForegroundColor Yellow
Write-Host "  - Ruta local: $LocalPath" -ForegroundColor Yellow
Write-Host "  - Ruta remota: $RemotePath" -ForegroundColor Yellow
Write-Host "  - Archivo de clave: $KeyPath" -ForegroundColor Yellow
Write-Host ""

# Confirmar antes de continuar
$confirmation = Read-Host "Deseas continuar con el despliegue? (S/N)"
if ($confirmation -ne 'S' -and $confirmation -ne 's') {
    Write-Host "[INFO] Operacion cancelada por el usuario."
    exit 0
}

# Verificar si OpenSSH está disponible
$useOpenSsh = Test-SshCommand

if ($useOpenSsh) {
    Write-Host "[INFO] Se utilizara OpenSSH para la transferencia." -ForegroundColor Cyan
    
    # FASE 1: Preparar el directorio remoto (preservando enlaces simbólicos)
    Write-Host "[PREPARE] Preparando el directorio remoto..." -ForegroundColor Cyan
    
    # Cambiamos temporalmente los permisos a rlopez:www-data
    Write-Host "[PREPARE] Cambiando propietario a $RemoteUser:www-data para facilitar la transferencia..." -ForegroundColor Cyan
    
    # Comando específico con nombres literales para evitar interpretación errónea
    $tempOwnershipScript = "sudo chown -R rlopez:www-data '$RemotePath' && sudo chmod -R 775 '$RemotePath'"
    $tempOwnershipCommand = "ssh -p $RemotePort -i `"$KeyPath`" $RemoteUser@$RemoteIP `"$tempOwnershipScript`""
    
    Write-Host "[DEBUG] Ejecutando: $tempOwnershipCommand" -ForegroundColor Gray
    $tempResult = Invoke-Expression $tempOwnershipCommand
    Write-Host "[PREPARE] Resultado: $tempResult" -ForegroundColor Cyan
    
    # Verificar que ahora tenemos permisos
    $checkScript = "ls -la '$RemotePath' && if [ -w '$RemotePath' ]; then echo 'Permisos OK'; else echo 'Todavia hay problemas con permisos'; fi"
    $checkCommand = "ssh -p $RemotePort -i `"$KeyPath`" $RemoteUser@$RemoteIP `"$checkScript`""
    
    Write-Host "[PREPARE] Verificando permisos..." -ForegroundColor Cyan
    Write-Host "[DEBUG] Ejecutando: $checkCommand" -ForegroundColor Gray
    $permissionResult = Invoke-Expression $checkCommand
    Write-Host "[PREPARE] Resultado: $permissionResult" -ForegroundColor Cyan
    
    # Si aún hay problemas, intentamos una solución más agresiva
    if ($permissionResult -like "*Todavia hay problemas con permisos*") {
        Write-Host "[PREPARE] Intentando solución alternativa con permisos..." -ForegroundColor Yellow
        $fixScript = "sudo mkdir -p '$RemotePath' && sudo chown -R rlopez:www-data '$RemotePath' && sudo chmod -R 775 '$RemotePath' && echo 'Permisos aplicados con método alternativo'"
        $fixCommand = "ssh -p $RemotePort -i `"$KeyPath`" $RemoteUser@$RemoteIP `"$fixScript`""
        Write-Host "[DEBUG] Ejecutando: $fixCommand" -ForegroundColor Gray
        $fixResult = Invoke-Expression $fixCommand
        Write-Host "[PREPARE] Resultado: $fixResult" -ForegroundColor Cyan
        
        # Verificamos nuevamente los permisos
        $permissionResult = Invoke-Expression $checkCommand
        Write-Host "[PREPARE] Verificando permisos nuevamente: $permissionResult" -ForegroundColor Cyan
    }
    
    # FASE 2: Transferir archivos
    Write-Host "[UPLOAD] Subiendo archivos al servidor..." -ForegroundColor Cyan
    Write-Host "[INFO] Este proceso puede tomar un tiempo dependiendo del tamano del sitio y la velocidad de conexion..."
    
    $scpCommand = "scp -r -P $RemotePort -i `"$KeyPath`" `"${LocalPath}*`" `"${RemoteUser}@${RemoteIP}:$RemotePath`""
    Write-Host "[DEBUG] Ejecutando: $scpCommand" -ForegroundColor Gray
    
    try {
        Invoke-Expression $scpCommand
        
        if ($LASTEXITCODE -eq 0) {
            # FASE 3: Ajustar propietario final para el servidor web
            Write-Host "[CHOWN] Restaurando propietario a www-data:www-data y estableciendo permisos finales..." -ForegroundColor Cyan
            
            $finalizeScript = "sudo chown -R www-data:www-data '$RemotePath' && sudo chmod -R 755 '$RemotePath' && sudo find '$RemotePath' -type d -exec chmod g+s {} \;"
            $finalizeCommand = "ssh -p $RemotePort -i `"$KeyPath`" $RemoteUser@$RemoteIP `"$finalizeScript`""
            
            Write-Host "[DEBUG] Ejecutando: $finalizeCommand" -ForegroundColor Gray
            $finalResult = Invoke-Expression $finalizeCommand
            Write-Host "[CHOWN] Resultado: $finalResult" -ForegroundColor Cyan
            
            Write-Host "[DONE] Deploy completado exitosamente!" -ForegroundColor Green
        } else {
            Write-Host "[ERROR] El comando SCP fallo con codigo $LASTEXITCODE" -ForegroundColor Red
            Write-Host "[SOLUCION] Conectate al servidor y ejecuta:" -ForegroundColor Yellow
            Write-Host "  sudo chown -R www-data:www-data $RemotePath" -ForegroundColor Yellow
            Write-Host "  sudo chmod -R 775 $RemotePath" -ForegroundColor Yellow
            Write-Host "  sudo find $RemotePath -type d -exec chmod g+s {} \;" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "[ERROR] Ocurrio un error al ejecutar SCP:" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
} else {
    # Versión PuTTY (si no está disponible OpenSSH)
    Write-Host "[INFO] OpenSSH no disponible, usando PSCP (PuTTY)." -ForegroundColor Cyan
    Write-Host "[CONSEJO] Se recomienda usar OpenSSH para Windows para una mejor compatibilidad." -ForegroundColor Yellow
    
    # Código para PuTTY (puedes implementar esta parte si lo necesitas)
}