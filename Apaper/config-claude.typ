#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)


// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)


#show: simple-theme.with(aspect-ratio: "16-9", footer: [APaper Env - v1.\*])

#title-slide[
  = Claude Code Configuration for APaper

  #v(2em)

  isomo #footnote[github/jiahaoxiang2000]

  #v(2em)
  #datetime.today().display()
]


= Configuration Details

== Settings Overview

```json .claude/settings.json
{
  "permissions": {
    "allow": ["WebFetch", "WebSearch", "Write", "Bash", "Edit", "MultiEdit"],
    "defaultMode": "allowEdits"
  },
  "enableAllProjectMcpServers": true,
  "env": {},
  "includeCoAuthoredBy": true
}
```

#pagebreak()

*Key Features:*
- Comprehensive tool permissions for research workflows
- Automatic MCP server integration
- Co-authored commit attribution

== Custom Commands

=== Academic Research Commands

#alternatives[
  _Paper Search_
  ```markdown
  /search-papers - Multi-platform search

  Supports:
  • IACR ePrint Archive
  • Google Scholar
  • Crossref
  • CryptoBib
  ```][
  _Crypto Research_
  ```markdown
  /crypto-research - Specialized assistant

  Features:
  • IACR paper analysis
  • Research trend identification
  • Bibliography management
  ```][
  _Writing Assistant_
  ```markdown
  /wpaper - Academic writing enhancement

  Capabilities:
  • Language optimization
  • Technical precision
  • Methodology descriptions
  ```
]

== MCP Integration

=== Available Tools

- `mcp__all-in-mcp__search-iacr-papers`
- `mcp__all-in-mcp__search-google-scholar-papers`
- `mcp__all-in-mcp__search-crossref-papers`
- `mcp__all-in-mcp__search-cryptobib-papers`
- `mcp__all-in-mcp__download-iacr-paper`
- `mcp__all-in-mcp__read-iacr-paper`
- `mcp__all-in-mcp__read-pdf`


= Setup Instructions

== Prerequisites

1. *Install UV*: `curl -LsSf https://astral.sh/uv/install.sh | sh`
2. *Create virtual environment*: `uv venv`
3. *Install MCP tools*: `uv pip install all-in-mcp`

== Claude MCP Configuration

Project-Specific Configuration


```json .mcp.json
{
  "mcpServers": {
    "all-in-mcp": {
      "command": "uv",
      "args": ["run", "all-in-mcp"]
    }
  },
}
```

== Usage Examples

=== Research Workflow

```bash
# Search for papers
/search-papers "zero knowledge proofs" on IACR

# Analyze findings
/crypto-research analyze trends in ZKP

# Enhance writing
/wpaper methodology "Our protocol consists of..."
```

= Thanks