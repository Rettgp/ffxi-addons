# FFXI Addons Dev Mode Toggle Script
# Switches between development mode (symlinks) and release mode (normal folders)

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev", "release")]
    [string]$Mode,
    
    [Parameter(Mandatory=$false)]
    [string]$WindowerPath = "C:\Program Files (x86)\PlayOnline\Windower4\addons"
)

# List of addons to manage
$addons = @(
    "barfiller",
    "enemybar",
    "equipviewer",
    "nmscanner",
    "scoreboard",
    "xivbar",
    "XIVHotbar",
    "zonename"
)

$repoPath = Split-Path -Parent $PSCommandPath

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Requesting Administrator privileges..." -ForegroundColor Yellow
    
    # Build the argument list to pass to the elevated process
    $argList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Mode $Mode"
    if ($PSBoundParameters.ContainsKey('WindowerPath')) {
        $argList += " -WindowerPath `"$WindowerPath`""
    }
    
    # Relaunch the script as administrator
    Start-Process powershell.exe -Verb RunAs -ArgumentList $argList -Wait
    exit
}

# Verify Windower path exists
if (-not (Test-Path $WindowerPath)) {
    Write-Host "ERROR: Windower addons path not found: $WindowerPath" -ForegroundColor Red
    Write-Host "Please specify the correct path using -WindowerPath parameter" -ForegroundColor Yellow
    exit 1
}

Write-Host "`nFFXI Addons Dev Mode Toggle" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "Windower Path: $WindowerPath" -ForegroundColor Gray
Write-Host "Repository Path: $repoPath" -ForegroundColor Gray
Write-Host ""

if ($Mode -eq "dev") {
    Write-Host "Switching to DEV MODE (creating file symlinks)..." -ForegroundColor Green
    Write-Host ""
    
    foreach ($addon in $addons) {
        $targetDir = Join-Path $WindowerPath $addon
        $sourceDir = Join-Path $repoPath $addon
        
        # Check if source exists in repo
        if (-not (Test-Path $sourceDir)) {
            Write-Host "  [SKIP] $addon - not found in repository" -ForegroundColor Yellow
            continue
        }
        
        # Ensure target directory exists
        if (-not (Test-Path $targetDir)) {
            Write-Host "  [CREATE] $addon - creating directory" -ForegroundColor Cyan
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        
        # Get all files and subdirectories from source, recursively
        $sourceItems = Get-ChildItem -Path $sourceDir -Recurse
        $linkedCount = 0
        $skippedCount = 0
        
        foreach ($sourceItem in $sourceItems) {
            # Get relative path from source directory
            $relativePath = $sourceItem.FullName.Substring($sourceDir.Length + 1)
            $targetPath = Join-Path $targetDir $relativePath
            
            # Skip anything inside images/ or icons/ folders
            if ($relativePath -match '(^|\\)(images|icons)(\\|$)') {
                continue
            }
            
            if ($sourceItem.PSIsContainer) {
                # Create directory if it doesn't exist
                if (-not (Test-Path $targetPath)) {
                    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
                }
            } else {
                # Handle file symlink
                $shouldLink = $true
                
                if (Test-Path $targetPath) {
                    $existingItem = Get-Item $targetPath -Force
                    
                    # If already a symlink pointing to our source, skip
                    if (($existingItem.LinkType -eq "SymbolicLink" -or $existingItem.LinkType -eq "HardLink") -and 
                        $existingItem.Target -eq $sourceItem.FullName) {
                        $shouldLink = $false
                        $skippedCount++
                    } else {
                        # Remove existing file or incorrect symlink
                        Remove-Item $targetPath -Force
                    }
                }
                
                if ($shouldLink) {
                    try {
                        New-Item -ItemType SymbolicLink -Path $targetPath -Target $sourceItem.FullName -Force | Out-Null
                        $linkedCount++
                    } catch {
                        Write-Host "  [ERROR] Failed to link $relativePath : $_" -ForegroundColor Red
                    }
                }
            }
        }
        
        if ($linkedCount -gt 0) {
            Write-Host "  [LINKED] $addon - $linkedCount file(s) linked" -ForegroundColor Green
        }
        if ($skippedCount -gt 0) {
            Write-Host "  [OK] $addon - $skippedCount file(s) already linked" -ForegroundColor Gray
        }
    }
    
    Write-Host "`nDEV MODE ACTIVE - Changes in your git repo will be live in-game!" -ForegroundColor Green
    
} elseif ($Mode -eq "release") {
    Write-Host "Switching to RELEASE MODE (replacing symlinks with real files)..." -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($addon in $addons) {
        $targetDir = Join-Path $WindowerPath $addon
        $sourceDir = Join-Path $repoPath $addon
        
        if (-not (Test-Path $targetDir)) {
            Write-Host "  [SKIP] $addon - doesn't exist in Windower" -ForegroundColor Gray
            continue
        }
        
        if (-not (Test-Path $sourceDir)) {
            Write-Host "  [SKIP] $addon - not found in repository" -ForegroundColor Yellow
            continue
        }
        
        # Find and replace all symlinked files with real copies
        $allFiles = Get-ChildItem -Path $targetDir -Recurse -File -Force
        $replacedCount = 0
        
        foreach ($file in $allFiles) {
            if ($file.LinkType -eq "SymbolicLink" -or $file.LinkType -eq "HardLink") {
                # Check if it's pointing to our repo
                if ($file.Target -and $file.Target.StartsWith($repoPath)) {
                    $symlinkTarget = $file.Target
                    
                    # Remove the symlink
                    Remove-Item $file.FullName -Force
                    
                    # Copy the actual file from repo
                    if (Test-Path $symlinkTarget) {
                        Copy-Item $symlinkTarget $file.FullName -Force
                        $replacedCount++
                    }
                }
            }
        }
        
        if ($replacedCount -gt 0) {
            Write-Host "  [REPLACED] $addon - $replacedCount symlink(s) replaced with real files" -ForegroundColor Green
        } else {
            Write-Host "  [OK] $addon - no dev symlinks found" -ForegroundColor Gray
        }
    }
    
    Write-Host "`nRELEASE MODE ACTIVE - Auto-updater can now manage these addons." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Cyan
