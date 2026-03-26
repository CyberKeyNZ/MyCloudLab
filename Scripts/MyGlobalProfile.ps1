# ===========================================================
# PowerShell 7 Global Profile (PJ's CyberLab)
# Location: D:\CloudLab\Scripts\MyGlobalProfile.ps1
# ===========================================================

# --- 1. Root Variables (Path Anchors) ---
# This ensures all your scripts know where your drives are.
if (-not (Test-Path variable:Global:CloudLabRoot)) { 
    $Global:CloudLabRoot = "D:\CloudLab" 
}

# --- 2. Logging & Auditing (The SOC Mindset) ---
# Automatically creates a log folder if it's missing.
$Global:CyberLabLogs = Join-Path $Global:CloudLabRoot "00_AdminDocs\Logs\PowerShell"
if (-not (Test-Path $Global:CyberLabLogs)) {
    New-Item -Path $Global:CyberLabLogs -ItemType Directory -Force | Out-Null
}

# Starts a background transcript of every session for your audit trail.
$LogFile = Join-Path $Global:CyberLabLogs "Session_$((Get-Date).ToString('yyyyMMdd_HHmm')).log"
Start-Transcript -Path $LogFile -Append -ErrorAction SilentlyContinue

# --- 3. Strict Mode (Coding Mastery) ---
# Forces better scripting habits by alerting you to typos/errors.
Set-Strictmode -Version Latest

# --- 4. Navigation Aliases (Fast Typing) ---
function cdlab { Set-Location -Path $Global:CloudLabRoot }
function cdtools { Set-Location -Path (Join-Path $Global:CloudLabRoot "Tools") }

# --- 5. The GitHub Sync Tool ---
function Invoke-LabSync {
    <#
    .SYNOPSIS
        Automatically pushes local lab changes to GitHub.
    #>
    param (
        [string]$Message = "Auto-sync from PC: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    )
    Write-Host "--- Syncing CloudLab to GitHub ---" -ForegroundColor Cyan
    Set-Location $Global:CloudLabRoot
    git add .
    git commit -m $Message
    git push origin main
    Write-Host "--- Sync Complete! ---" -ForegroundColor Green
}

# Alias so you only have to type 'sync'
Set-Alias sync Invoke-LabSync

# --- 6. Visual Customization ---
Write-Host "PJ's CyberLab Loaded (PS v$($PSVersionTable.PSVersion))" -ForegroundColor Yellow
Write-Host "Current Lab Root: $Global:CloudLabRoot" -ForegroundColor Gray