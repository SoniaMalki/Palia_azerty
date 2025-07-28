# ===============================================
#   Palia AZERTY Patcher
#   Corrige les touches pour ZQSD et F1-F8.
# ===============================================

# Stoppe le script à la première erreur pour éviter les problèmes
$ErrorActionPreference = 'Stop'

$colors = @{
    Info    = 'Cyan'
    Success = 'Green'
    Warning = 'Yellow'
    Error   = 'Red'
    Title   = 'White'
}

# --- On définit les chemins importants ---
$userDir = $env:USERPROFILE
$configDir = Join-Path -Path $userDir -ChildPath 'AppData\Local\Palia\Saved\Config\WindowsClient'
$iniFile = Join-Path -Path $configDir -ChildPath 'GameUserSettings.ini'
$backupFile = Join-Path -Path $configDir -ChildPath 'GameUserSettings_original.ini'

$ahkDir = Join-Path -Path $userDir -ChildPath 'Documents\AutoHotkey'
$ahkFile = Join-Path -Path $ahkDir -ChildPath 'Palia.ahk'
$autoHotkeyExe = 'C:\Program Files\AutoHotkey\v2\AutoHotkey.exe' # À ajuster si AHK est installé ailleurs

# --- Chemin du script (méthode pour .ps1 et .exe) ---
if ($PSScriptRoot) {
    $scriptDir = $PSScriptRoot
} else {
    $scriptDir = Split-Path -Path (Get-Process -Id $PID).Path -Parent
}
$localAhkFile = Join-Path -Path $scriptDir -ChildPath 'Palia.ahk'


# --- Début du Script ---

Clear-Host
Write-Host "=================================================" -ForegroundColor $colors.Title
Write-Host "      Palia AZERTY Patch for French Keyboards    " -ForegroundColor $colors.Title
Write-Host "=================================================" -ForegroundColor $colors.Title
Write-Host

# On vérifie si le fichier de config du jeu existe bien
if (-not (Test-Path -Path $iniFile)) {
    Write-Host "[ERROR] GameUserSettings.ini file not found." -ForegroundColor $colors.Error
    Write-Host "        Expected path: $iniFile" -ForegroundColor $colors.Error
    Write-Host "        Please make sure you have launched the game at least once." -ForegroundColor $colors.Error
    Read-Host "Press Enter to exit."
    exit
}

# --- Gestion de la Sauvegarde ---
if (Test-Path -Path $backupFile) {
    Write-Host "[WARNING] A backup file (GameUserSettings_original.ini) already exists." -ForegroundColor $colors.Warning
    try {
        $choice = Read-Host "Do you want to overwrite it? (Y/N)"
        if ($choice -match '^[yY]') {
            Copy-Item -Path $iniFile -Destination $backupFile -Force
            Write-Host "[INFO] The backup has been overwritten." -ForegroundColor $colors.Info
        } else {
            Write-Host "[INFO] Existing backup has been kept." -ForegroundColor $colors.Info
        }
    } catch {
        Write-Host "[ERROR] Invalid input." -ForegroundColor $colors.Error
        Read-Host "Press Enter to exit."
        exit
    }
} else {
    Copy-Item -Path $iniFile -Destination $backupFile
    Write-Host "[SUCCESS] Original configuration backup created." -ForegroundColor $colors.Success
}

Write-Host

# --- Modification des Touches ---
Write-Host "[INFO] Applying AZERTY key remapping..." -ForegroundColor $colors.Info

try {
    # On lit tout le fichier d'un coup
    $content = Get-Content -Path $iniFile -Raw

    # La liste des touches à changer.
    # On utilise [ordered] pour que l'affichage soit propre et dans l'ordre désiré.
    $keyMappings = [ordered]@{
        # Mouvement ZQSD
        'IA_MoveForward'                  = 'Z'
        'IA_MoveBackward'                 = 'S'
        'IA_MoveLeft'                     = 'Q'
        'IA_MoveRight'                    = 'D'
        
        # Autres touches AZERTY spécifiques
        'IA_ActionBar_SelectPreviousSlot' = 'A'   # Remplace Q par A
        'IA_PlacementMode_ToggleFreePlacement' = 'W'   # Remplace Z par W

        # Barre d'outils F1-F8
        'IA_ActionBar_SelectSlot1'        = 'F1'
        'IA_ActionBar_SelectSlot2'        = 'F2'
        'IA_ActionBar_SelectSlot3'        = 'F3'
        'IA_ActionBar_SelectSlot4'        = 'F4'
        'IA_ActionBar_SelectSlot5'        = 'F5'
        'IA_ActionBar_SelectSlot6'        = 'F6'
        'IA_ActionBar_SelectSlot7'        = 'F7'
        'IA_ActionBar_SelectSlot8'        = 'F8'
    }

    $regexPattern = '(InputAction="{0}",InputKeys=\(\(Key=)[A-Za-z0-9]+'
    
    # On applique chaque modification
    foreach ($action in $keyMappings.Keys) {
        $newKey = $keyMappings[$action]
        
        # On construit la regex de manière sûre avec l'opérateur de format -f
        $regex = $regexPattern -f $action
        $replacement = '${1}' + $newKey

        if ($content -match $regex) {
            $content = $content -replace $regex, $replacement
            Write-Host "  - '$action' remapped to key '$newKey'." -ForegroundColor $colors.Success
        } else {
            Write-Host "  - [WARNING] Action '$action' was not found in the file. It might have been removed or renamed in a game update." -ForegroundColor $colors.Warning
        }
    }

    # On réécrit le fichier avec les modifications
    $content | Set-Content -Path $iniFile -NoNewline -Encoding UTF8

    Write-Host "[SUCCESS] Keys have been successfully remapped." -ForegroundColor $colors.Success
} catch {
    Write-Host "[ERROR] An error occurred while modifying the configuration file." -ForegroundColor $colors.Error
    Write-Host $_.Exception.Message -ForegroundColor $colors.Error
    Read-Host "Press Enter to exit."
    exit
}

Write-Host

# --- Gestion du Script AutoHotkey ---
Write-Host "[INFO] Setting up the AutoHotkey script..." -ForegroundColor $colors.Info

# On crée le dossier s'il n'existe pas
if (-not (Test-Path -Path $ahkDir)) {
    New-Item -Path $ahkDir -ItemType Directory -Force | Out-Null
    Write-Host "[INFO] AutoHotkey directory created at: $ahkDir" -ForegroundColor $colors.Info
}

# On cherche et on copie le script AHK
if (Test-Path -Path $localAhkFile) {
    try {
        Copy-Item -Path $localAhkFile -Destination $ahkFile -Force
        Write-Host "[SUCCESS] AutoHotkey script copied to: $ahkFile" -ForegroundColor $colors.Success
    } catch {
        Write-Host "[ERROR] Could not copy the AutoHotkey script." -ForegroundColor $colors.Error
        Write-Host $_.Exception.Message -ForegroundColor $colors.Error
        Read-Host "Press Enter to exit."
        exit
    }
} else {
    Write-Host "[ERROR] Palia.ahk not found in script directory: $localAhkFile" -ForegroundColor $colors.Error
    Read-Host "Press Enter to exit."
    exit
}

# On lance le script AHK
if (Test-Path -Path $autoHotkeyExe) {
    # On vérifie s'il ne tourne pas déjà pour éviter les doublons
    $processName = "AutoHotkey"
    $scriptName = "Palia.ahk"
    $existingProcess = Get-Process -Name $processName -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like "*$scriptName*" }
    
    if (-not $existingProcess) {
        Start-Process -FilePath $autoHotkeyExe -ArgumentList "`"$ahkFile`""
        Write-Host "[SUCCESS] AutoHotkey script launched." -ForegroundColor $colors.Success
    } else {
        Write-Host "[INFO] The Palia AutoHotkey script appears to be already running." -ForegroundColor $colors.Info
    }
} else {
    Write-Host "[WARNING] AutoHotkey v2 executable not found at '$autoHotkeyExe'." -ForegroundColor $colors.Warning
    Write-Host "           Please verify the installation or adjust the path in the script." -ForegroundColor $colors.Warning
}



# --- Ajout du script au démarrage (Startup) ---
Write-Host "INFO: Ajout du script AutoHotkey au démarrage..." -ForegroundColor $colors.Info

$startupFolder = [Environment]::GetFolderPath("Startup")
$shortcutPath = Join-Path -Path $startupFolder -ChildPath "Palia.ahk.lnk"

# Crée un raccourci vers le script AHK
$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $autoHotkeyExe
$shortcut.Arguments = "`"$ahkFile`""
$shortcut.WorkingDirectory = $ahkDir
$shortcut.WindowStyle = 1
$shortcut.IconLocation = "$autoHotkeyExe,0"
$shortcut.Save()

Write-Host "[SUCCESS] Shortcut added to Windows startup: $shortcutPath" -ForegroundColor $colors.Success

Write-Host
Write-Host "[SUCCESS] Patch process completed!" -ForegroundColor $colors.Success
Read-Host "Press Enter to close this window."