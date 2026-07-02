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


#show: simple-theme.with(aspect-ratio: "16-9", footer: [AI Agent Workflow ])

#title-slide[
  = APaper: Auto analysis research direction

  #v(2em)

  isomo #footnote[github/jiahaoxiang2000]

  #v(2em)
  #datetime.today().display()
]


= Auto Analysis Research Direction

== Example Usage

```bash
/find-paper "post-quantum cryptography implementation"
```

*Agent Workflow Output:*
1. Search IACR for PQC papers (15 results)
2. Verify quality via CryptoBib (12 validated)
3. Deep analysis of top 5 papers
4. Generate structured research summary

== Research Direction Analysis Process

The `/find-paper` command demonstrates a systematic AI agent workflow for academic research analysis:

=== Step 1: Primary Literature Search
#alternatives[
  _IACR ePrint Archive_
  ```typst
  mcp__all-in-mcp__search-iacr-papers
  • Premier cryptographic research venue
  • Real-time access to latest papers
  • Comprehensive metadata extraction
  ```][
  _Multi-Platform Coverage_
  ```typst
  • Extract: title, authors, abstract
  • Filter: publication year, relevance
  • Rank: by methodological alignment
  ```
]

#pagebreak()

=== Step 2: Quality Verification
```typst
mcp__all-in-mcp__search-cryptobib-papers
```
- Validates peer-review status
- Ensures academic quality standards
- Filters out non-indexed publications

#pagebreak()

=== Step 3: Deep Content Analysis
```typst
mcp__all-in-mcp__read-iacr-paper
```
- Extracts key contributions
- Analyzes methodological approaches
- Identifies research gaps and opportunities

== Workflow Benefits

#grid(
  columns: 2,
  gutter: 1em,
  [
    *Systematic Approach*
    - Eliminates research bias
    - Ensures comprehensive coverage
    - Maintains quality standards
  ],
  [
    *AI-Powered Efficiency*
    - Automated relevance scoring
    - Instant cross-referencing
    - Structured output generation
  ],
)


= Thanks
