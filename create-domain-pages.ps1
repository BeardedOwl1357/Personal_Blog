$ArticlesRoot = Join-Path $PSScriptRoot "_articles"
$DomainsRoot = Join-Path $PSScriptRoot "_domains"

if (-not (Test-Path $DomainsRoot)) {
    New-Item -ItemType Directory -Path $DomainsRoot -Force | Out-Null
}

$domains = Get-ChildItem $ArticlesRoot -Directory

foreach ($domain in $domains) {

    $domainSlug = $domain.Name

    $articles = Get-ChildItem $domain.FullName -Filter "*.md" -File |
        Sort-Object Name

    $articleCards = ""

    foreach ($article in $articles) {

        $frontMatter = Get-Content $article.FullName -Raw

        if ($frontMatter -match 'title:\s*"([^"]+)"') {
            $title = $Matches[1]
        }
        else {
            $title = [System.IO.Path]::GetFileNameWithoutExtension(
                $article.Name
            )
        }

        if ($frontMatter -match 'description:\s*"([^"]+)"') {
            $description = $Matches[1]
        }
        else {
            $description = ""
        }

        $articleSlug = [System.IO.Path]::GetFileNameWithoutExtension(
            $article.Name
        )

        $articleCards += @"

<a class="card" href="{{ '/$domainSlug/$articleSlug/' | relative_url }}">

  <div class="card-title">
    $title
  </div>

  <div class="card-description">
    $description
  </div>

  <div class="card-action">
    Read →
  </div>

</a>

"@
    }

    $domainTitle = ($domain.Name -replace '-', ' ')
    $domainTitle = (Get-Culture).TextInfo.ToTitleCase($domainTitle)

    $content = @"
---
layout: domain
title: "$domainTitle"
permalink: /$domainSlug/
---

<p class="breadcrumb">
  <a href="{{ '/' | relative_url }}">Home</a>
  / $domainTitle
</p>

<h1>$domainTitle</h1>

<div class="card-grid">
$articleCards
</div>
"@

    $outputFile = Join-Path $DomainsRoot "$domainSlug.md"

    [System.IO.File]::WriteAllText(
        $outputFile,
        $content,
        [System.Text.UTF8Encoding]::new($false)
    )

    Write-Host "Generated: $outputFile" -ForegroundColor Green
}

Write-Host ""
Write-Host "Domain pages generated successfully." -ForegroundColor Cyan