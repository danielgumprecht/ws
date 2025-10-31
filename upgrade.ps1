<#
.SYNOPSIS
Findet ein Laufwerk mit dem Volumenlabel "TOOLS" und kopiert alle ISO-Dateien nach C:\_Installs

.BESCHREIBUNG
Das Skript sucht zuerst mit Get-Volume (falls verfügbar) nach dem Label "TOOLS",
fällt ansonsten auf WMI/CIM zurück. Gefundene ISO-Dateien im Root werden kopiert.
Falls im Root keine ISO gefunden werden, wird optional rekursiv gesucht.
#>

param(
    [string]$Label = "TOOLS",
    [string]$Destination = "C:\_Installs",
    [switch]$RecurseIfNoneFound
)

try {
    # Versuch 1: Get-Volume (PowerShell Storage-Modul)
    $volume = $null
    if (Get-Command -Name Get-Volume -ErrorAction SilentlyContinue) {
        $volume = Get-Volume -ErrorAction SilentlyContinue |
                  Where-Object { $_.FileSystemLabel -and $_.FileSystemLabel -ieq $Label } |
                  Select-Object -First 1
    }

    # Versuch 2: WMI/CIM-Fallback
    if (-not $volume) {
        $logical = Get-CimInstance -ClassName Win32_LogicalDisk -ErrorAction SilentlyContinue |
                   Where-Object { $_.VolumeName -and $_.VolumeName -ieq $Label } |
                   Select-Object -First 1

        if ($logical) {
            # Erzeuge ein ähnliches Objekt mit DriveLetter-Eigenschaft für einheitliche Verarbeitung
            $volume = [PSCustomObject]@{ DriveLetter = $logical.DeviceID }
        }
    }

    if (-not $volume -or -not $volume.DriveLetter) {
        Write-Error "Kein Laufwerk mit Label '$Label' gefunden."
        exit 1
    }

    # Normiere Pfad (DriveLetter kann "E:" sein -> "E:\")
    $drivePath = $volume.DriveLetter
    if ($drivePath -notlike "*\"){
        $drivePath = "$drivePath\"
    }

    # Zielverzeichnis anlegen
    if (-not (Test-Path -Path $Destination)) {
        New-Item -Path $Destination -ItemType Directory -Force | Out-Null
    }

    # Suche ISO-Dateien im Root des Laufwerks
    $isos = Get-ChildItem -Path (Join-Path $drivePath "*.iso") -File -ErrorAction SilentlyContinue

    # Optional rekursiv suchen, falls im Root nichts gefunden wurde und Schalter gesetzt ist
    if ((-not $isos -or $isos.Count -eq 0) -and $RecurseIfNoneFound) {
        $isos = Get-ChildItem -Path $drivePath -Filter *.iso -File -Recurse -ErrorAction SilentlyContinue
    }

    if (-not $isos -or $isos.Count -eq 0) {
        Write-Error "Keine ISO-Dateien auf Laufwerk '$drivePath' gefunden."
        exit 2
    }

    foreach ($iso in $isos) {
        $destPath = Join-Path $Destination $iso.Name
        Write-Output "Kopiere '$($iso.FullName)' nach '$destPath'..."
        Copy-Item -Path $iso.FullName -Destination $destPath -Force -ErrorAction Stop
    }

    Write-Output "Fertig. $($isos.Count) Datei(en) kopiert."
    exit 0
}
catch {
    Write-Error "Fehler: $($_.Exception.Message)"
    exit 99
}