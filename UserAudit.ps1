# Get all local user accounts
$users = Get-LocalUser | Select-Object Name, Enabled, LastLogon, Description
# Output to terminal and file
$users | Format-Table
$users | Out-File -FilePath "Audit_Results.txt"
Write-Host "Success! Results saved to Audit_Results.txt" -ForegroundColor Green