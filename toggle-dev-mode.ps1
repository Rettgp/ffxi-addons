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
    Write-Host "Switching to DEV MODE (creating symlinks)..." -ForegroundColor Green
    Write-Host ""
    
    foreach ($addon in $addons) {
        $target = Join-Path $WindowerPath $addon
        $source = Join-Path $repoPath $addon
        
        # Check if source exists in repo
        if (-not (Test-Path $source)) {
            Write-Host "  [SKIP] $addon - not found in repository" -ForegroundColor Yellow
            continue
        }
        
        # Check if target already exists
        if (Test-Path $target) {
            $item = Get-Item $target
            
            # If it's already a symlink pointing to our repo, skip
            if ($item.LinkType -eq "SymbolicLink" -or $item.LinkType -eq "Junction") {
                if ($item.Target -eq $source) {
                    Write-Host "  [OK] $addon - already linked" -ForegroundColor Gray
                    continue
                } else {
                    Write-Host "  [WARN] $addon - existing symlink to different location, removing..." -ForegroundColor Yellow
                    Remove-Item $target -Force -Recurse
                }
            } else {
                # Regular folder exists - back it up and remove
                $backup = "$target.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                Write-Host "  [BACKUP] $addon - backing up to $(Split-Path -Leaf $backup)" -ForegroundColor Yellow
                Move-Item $target $backup -Force
            }
        }
        
        # Create the symlink
        try {
            New-Item -ItemType SymbolicLink -Path $target -Target $source -Force | Out-Null
            Write-Host "  [CREATED] $addon -> $source" -ForegroundColor Green
        } catch {
            Write-Host "  [ERROR] $addon - Failed to create symlink: $_" -ForegroundColor Red
        }
    }
    
    Write-Host "`nDEV MODE ACTIVE - Changes in your git repo will be live in-game!" -ForegroundColor Green
    
} elseif ($Mode -eq "release") {
    Write-Host "Switching to RELEASE MODE (removing symlinks)..." -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($addon in $addons) {
        $target = Join-Path $WindowerPath $addon
        
        if (-not (Test-Path $target)) {
            Write-Host "  [SKIP] $addon - doesn't exist in Windower" -ForegroundColor Gray
            continue
        }
        
        $item = Get-Item $target
        
        # Only remove if it's a symlink
        if ($item.LinkType -eq "SymbolicLink" -or $item.LinkType -eq "Junction") {
            Write-Host "  [REMOVED] $addon - symlink removed" -ForegroundColor Yellow
            Remove-Item $target -Force
            
            # Check for backup and restore it
            $backups = Get-ChildItem -Path $WindowerPath -Filter "$addon.backup_*" | Sort-Object LastWriteTime -Descending
            if ($backups.Count -gt 0) {
                $latestBackup = $backups[0]
                Write-Host "  [RESTORED] $addon - from $($latestBackup.Name)" -ForegroundColor Green
                Move-Item $latestBackup.FullName $target -Force
            }
        } else {
            Write-Host "  [OK] $addon - already using regular folder" -ForegroundColor Gray
        }
    }
    
    Write-Host "`nRELEASE MODE ACTIVE - Auto-updater can now manage these addons." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Cyan
