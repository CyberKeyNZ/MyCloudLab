# Get all local user accounts
$users =Get-Content /etc/passwd | Select-String "/home/"
 # Output to terminal and file
$users | Format-Table
$users | Out-File -FilePath "Audit_Results.txt"
Write-Host "Success! Results saved to Audit_Results.txt" -ForegroundColor Green
Write-Host "--- Network Interface Audit ---" -ForegroundColor Cyan
Write-Host "--- Network Interface Audit ---" -ForegroundColor Cyan
$ipAddr = ip -4 -o addr show | ForEach-Object { 
    $parts = $_ -split '\s+'
    [PSCustomObject]@{
        Interface = $parts[1]
        IPAddress = $parts[3]
    }
}
$ipAddr | Format-Table
