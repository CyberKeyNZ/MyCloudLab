param(
  [string]$FocusArea = "Entra CA",
  [string]$Root = "D:\CloudLab"
)

$today = Get-Date -Format "yyyy-MM-dd"

$journalDir  = Join-Path $Root "Runbooks\Operator_Journal"
$evidenceDir = Join-Path $journalDir "Evidence\$today"
$journalFile = Join-Path $journalDir "$today`_$($FocusArea -replace '[^\w\- ]','' -replace ' ','_').md"

# Ensure folders exist
New-Item -ItemType Directory -Path $journalDir -Force | Out-Null
New-Item -ItemType Directory -Path $evidenceDir -Force | Out-Null

# Create journal file if missing
if (-not (Test-Path $journalFile)) {
@"
# Operator Journal — Session Log
Date: $today
Focus Area: $FocusArea

---

## 1️⃣ Objective (What was I trying to control or prove?)
> 

---

## 2️⃣ Change Made (What did I actually touch?)
- System:
- Policy / Rule / Script / Config:
- Scope (Who/What it affects):

---

## 3️⃣ Test Performed (How did I validate it safely?)
- Method:
- Expected Result:
- Actual Result:

---

## 4️⃣ Recovery Path (If this broke, how would I get back in?)
- Break-glass / Rollback method:
- Verified? (Yes / No)

---

## 5️⃣ Proof Collected (Where is the evidence?)
- Logs / Screenshots / Exports:
- Path:
  $evidenceDir

---

## Operator Notes
- What confused me:
- What clicked:
- What to drill next time:
"@ | Set-Content -Path $journalFile -Encoding UTF8
}

# Open in VS Code if available; otherwise open in Notepad
if (Get-Command code -ErrorAction SilentlyContinue) {
  code $journalFile
} else {
  notepad $journalFile
}

# Also open the evidence folder for quick saving of screenshots/exports
Start-Process explorer.exe $evidenceDir

Write-Host "Created/Opened journal: $journalFile"
Write-Host "Evidence folder:       $evidenceDir"

Set-Alias journal "D:\CloudLab\Scripts\Operator\New-OperatorJournal.ps1"

