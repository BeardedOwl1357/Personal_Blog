# Personal Blog

A lightweight, Markdown-based personal knowledge base hosted on GitHub Pages.

The project uses an Excel sheet as the structured source for articles, PowerShell scripts to convert new entries into Markdown, and Jekyll to generate the website.

## 1. Overview

The blog is organized by domain and topic:

```text
/Personal_Blog/
├── finance/
│   ├── cac/
│   ├── bonds/
│   └── ...
├── marketing/
├── operations/
└── product-management/
```

The homepage displays available domains. Selecting a domain shows all articles within that domain.

The project is intentionally simple and modular so that features such as search, analytics, encryption, and custom domains can be added later.

## 2. How to Use

The main source of structured article data is `Quotes.xlsx`.

The basic workflow is:

```text
Quotes.xlsx
    ↓
convert-excel-to-markdown.ps1
    ↓
_articles/<domain>/<topic>.md
    ↓
create-domain-pages.ps1
    ↓
Jekyll / GitHub Pages
    ↓
Website
```

Run the Excel conversion script:

```powershell
.\convert-excel-to-markdown.ps1
```

This creates Markdown files for articles that do not already exist.

Then generate the domain pages:

```powershell
.\create-domain-pages.ps1
```

Finally, commit and push the changes:

```powershell
git add .
git commit -m "Update articles"
git push
```

GitHub Pages automatically builds and publishes the updated website.

## 3. How to Add a New Article

### Step 1: Add the article to Excel

Add a new row to `Quotes.xlsx` using the existing columns:

| Column             | Purpose                                              |
| ------------------ | ---------------------------------------------------- |
| Domain             | Top-level area, such as Finance or Marketing         |
| Topic              | Article title                                        |
| Category           | Article category/type                                |
| Definition/Formula | Short definition or formula                          |
| Explanation        | Detailed explanation                                 |
| Pick Count         | Used by the external knowledge/notification workflow |

For example:

```text
Domain: Strategy
Topic: Porter's Five Forces
Category: Framework
Definition/Formula: A framework for analysing industry competition
Explanation: ...
```

### Step 2: Generate the Markdown file

Run:

```powershell
.\convert-excel-to-markdown.ps1
```

If `Strategy` is a new domain, the script automatically creates:

```text
_articles/
└── strategy/
```

and then:

```text
_articles/strategy/porters-five-forces.md
```

Existing Markdown articles are never overwritten.

This allows articles to be manually improved after their initial creation.

### Step 3: Generate the domain page

Run:

```powershell
.\create-domain-pages.ps1
```

This creates or updates the domain page:

```text
strategy.md
```

which becomes:

```text
/Personal_Blog/strategy/
```

The homepage automatically picks up the new domain.

### Step 4: Publish

```powershell
git add .
git commit -m "Add Porter's Five Forces"
git push
```

The article will then be available at:

```text
/Personal_Blog/strategy/porters-five-forces/
```

## 4. Tech Used

### GitHub Pages

Hosts the static website and automatically deploys changes pushed to the repository.

### Jekyll

Static site generator used by GitHub Pages.

Jekyll converts Markdown articles into HTML pages and handles layouts, collections, permalinks, and the homepage.

### Markdown

Articles are stored as Markdown files, making them easy to write, edit, version, and migrate.

### PowerShell

Used for automation:

* Converting Excel data into Markdown
* Creating domain folders
* Creating article files
* Generating domain pages

### Excel

`Quotes.xlsx` acts as the structured source for the knowledge base and the existing notification workflow.

### GitHub Actions

Automatically builds and deploys the Jekyll website whenever changes are pushed to the `main` branch.

### ntfy + Google Apps Script

The existing notification system uses Google Apps Script and ntfy to send notifications containing links to relevant articles.

## 5. Features

* Markdown-based articles
* Domain-based organization
* Topic-based article URLs
* Automatically generated domain pages
* Automatically generated homepage categories
* Mobile-friendly minimalist design
* Git-based version history
* Automatic GitHub Pages deployment
* Excel-to-Markdown automation
* Automatic creation of new domain folders
* Existing Markdown articles are protected from accidental overwrites
* Clean URLs such as:

```text
/Personal_Blog/finance/cac/
/Personal_Blog/marketing/anchoring-effect/
/Personal_Blog/product-management/automation-matrix/
```

### Planned / Possible Features

The project is intentionally modular and can later support:

* Full-text search
* Tags
* Related articles
* Dark mode
* Google Analytics
* Password-protected/encrypted articles
* Custom domain
* Better article navigation
* Backlinks between articles
* Automated ntfy integration
* RSS feed

## 6. Methodology

The project follows a separation-of-concerns approach.

### Structured data

Excel stores structured information about the knowledge base:

```text
Domain
Topic
Category
Definition/Formula
Explanation
Pick Count
```

### Content

Markdown files are the website's actual article content.

```text
_articles/
└── <domain>/
    └── <topic>.md
```

This separation allows the articles to evolve beyond the original Excel content without requiring changes to the spreadsheet.

### Generation

PowerShell acts as the bridge between structured data and website content:

```text
Excel
  ↓
PowerShell
  ↓
Markdown
```

The scripts create only missing articles, preventing existing manually edited Markdown files from being overwritten.

### Presentation

Jekyll handles the transformation from Markdown to HTML:

```text
Markdown
  ↓
Jekyll
  ↓
HTML
  ↓
GitHub Pages
```

The website itself contains minimal application logic. Most content is static, which keeps the system fast, inexpensive, and easy to maintain.

### Deployment

Git is the mechanism for publishing changes:

```text
Edit
  ↓
Generate
  ↓
git add
  ↓
git commit
  ↓
git push
  ↓
GitHub Actions
  ↓
GitHub Pages
```

The goal is to keep the system simple enough that adding a new article requires only a few commands while leaving room for more advanced features later.
