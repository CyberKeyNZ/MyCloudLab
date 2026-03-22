# --- DISK SECTION ---
Write-Host "Checking Disk Space on Root (/) Drive..." -ForegroundColor Yellow

Get-PSDrive / | Select-Object Name, Used, Free

# --- NETWORK SECTION ---
Write-Host "Checking Network Interfaces..." -ForegroundColor Green
ip -4 -o addr show | awk '{print $2, $4}'

# --- TIME DRIFT AUDIT ---
Write-Host "--- Time Drift Audit ---" -ForegroundColor Yellow

# 1. Compare System Clock to Hardware Clock (RTC)
$sysTime = Get-Date
Write-Host "System Time: $($sysTime.ToString('HH:mm:ss'))"

# 2. Check if the Hardware Clock is reachable
$hwCheck = sudo hwclock --show --verbose | Select-String "Hardware clock is"
Write-Host "HW Clock Status: $hwCheck"

# 3. Check NTP Sync Status (Crucial for Security Logs)
$ntpStatus = timedatectl show --property=NTPSynchronized
if ($ntpStatus -like "*yes*") {
    Write-Host "NTP Sync: [OK]" -ForegroundColor Green
} else {
    Write-Host "NTP Sync: [WARNING - Potential Drift]" -ForegroundColor Red
}
