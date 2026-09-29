$ArticlesRoot = Join-Path $PSScriptRoot "_articles"

$domains = Get-ChildItem $ArticlesRoot -Directory

foreach ($domain in $domains) {

    $domainSlug = $domain.Name

    $articles = Get-ChildItem $domain.FullName -Filter "*.md"

    $articleLinks = ""

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

        $articleLinks += @"

<li>
  <a href="{{ '/$domainSlug/$articleSlug/' | relative_url }}">
    $title
  </a>

  <div class="description">
    $description
  </div>
</li>

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

<h1>$domainTitle</h1>

<ul class="topic-list">
$articleLinks
</ul>
"@

    $outputFile = Join-Path $PSScriptRoot "$domainSlug.md"

    [System.IO.File]::WriteAllText(
        $outputFile,
        $content,
        [System.Text.UTF8Encoding]::new($false)
    )

    Write-Host "Created: $outputFile"
}