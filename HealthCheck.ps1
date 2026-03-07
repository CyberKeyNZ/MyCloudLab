# --- System Triage & Health Check ---
Write-Host "Checking Top 5 CPU Processes..." -ForegroundColor Cyan
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Format-Table Name, CPU

Write-Host "Checking Disk Space on C: Drive..." -ForegroundColor Yellow
Get-PSDrive C | Select-Object Name, Used, FreeGet-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5