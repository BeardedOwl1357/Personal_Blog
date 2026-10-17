git add .

if ($LASTEXITCODE -ne 0) {
    Write-Error "Git add failed."
    exit 1
}

$message = Read-Host "Enter commit message (press Enter for default: Generic addition)"

if ([string]::IsNullOrWhiteSpace($message)) {
    $message = "Generic addition"
}

Write-Host "Commit message: $message" -ForegroundColor Cyan

git commit -m "$message"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Git commit failed. Nothing pushed."
    exit 1
}

git push

if ($LASTEXITCODE -ne 0) {
    Write-Error "Git push failed."
    exit 1
}

Write-Host "Changes pushed successfully!" -ForegroundColor Green