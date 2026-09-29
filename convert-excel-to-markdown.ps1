Import-Module ImportExcel

$ExcelFile = Join-Path $PSScriptRoot "Quotes.xlsx"
$ArticlesRoot = Join-Path $PSScriptRoot "_articles"

function Convert-ToSlug {
    param (
        [string]$Text
    )

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return ""
    }

    $slug = $Text.ToLowerInvariant()

    # Replace ampersands with "and"
    $slug = $slug -replace '&', 'and'

    # Replace apostrophes
    $slug = $slug -replace "'", ''

    # Replace anything that is not a letter or number with "-"
    $slug = $slug -replace '[^a-z0-9]+', '-'

    # Remove leading/trailing hyphens
    $slug = $slug.Trim('-')

    return $slug
}

function Ensure-Folder {
    param (
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        Write-Host "Creating folder: $Path"
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

if (-not (Test-Path $ExcelFile)) {
    Write-Error "Excel file not found: $ExcelFile"
    exit 1
}

Write-Host ""
Write-Host "Reading: $ExcelFile"
Write-Host ""

$rows = Import-Excel -Path $ExcelFile -WorksheetName "Knowledge"

$createdCount = 0
$skippedCount = 0

foreach ($row in $rows) {

    $domain = [string]$row.Domain
    $topic = [string]$row.Topic
    $category = [string]$row.Category
    $definition = [string]$row.'Definition/Formula'
    $explanation = [string]$row.Explanation

    # Ignore completely empty rows
    if (
        [string]::IsNullOrWhiteSpace($domain) -and
        [string]::IsNullOrWhiteSpace($topic)
    ) {
        continue
    }

    # Domain and Topic are required
    if (
        [string]::IsNullOrWhiteSpace($domain) -or
        [string]::IsNullOrWhiteSpace($topic)
    ) {
        Write-Warning "Skipping row because Domain or Topic is missing."
        continue
    }

    $domainSlug = Convert-ToSlug $domain
    $topicSlug = Convert-ToSlug $topic

    $domainFolder = Join-Path $ArticlesRoot $domainSlug
    $filePath = Join-Path $domainFolder "$topicSlug.md"

    # Create domain folder if it doesn't exist
    Ensure-Folder $domainFolder

    # IMPORTANT:
    # Never overwrite an existing article.
    if (Test-Path $filePath) {
        Write-Host "Skipped (already exists): $filePath" -ForegroundColor Yellow
        $skippedCount++
        continue
    }

    $content = @"
---
title: "$topic"
domain: "$domain"
topic: "$topic"
category: "$category"
description: "$definition"
permalink: /$domainSlug/$topicSlug/
---

# $topic

## Definition / Formula

$definition

## Explanation

$explanation

"@

    # Write UTF-8 without BOM
    [System.IO.File]::WriteAllText(
        $filePath,
        $content,
        [System.Text.UTF8Encoding]::new($false)
    )

    Write-Host "Created: $filePath" -ForegroundColor Green
    $createdCount++
}

Write-Host ""
Write-Host "Done."
Write-Host ""
Write-Host "Created: $createdCount article(s)" -ForegroundColor Green
Write-Host "Skipped: $skippedCount existing article(s)" -ForegroundColor Yellow
Write-Host ""