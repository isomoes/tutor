#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
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

#show: simple-theme.with(aspect-ratio: "16-9", footer: [AI-Assisted Figure Drawing])

#title-slide[
  = Drawing Figures with AI/LLM
  #v(1em)
  *Apaper* -- Translating Structured Text to Visual Diagrams
  #v(2em)

  isomo #footnote[github/jiahaoxiang2000]

  #v(2em)
  #datetime.today().display()
]

= The Problem

== From Concept to Figure

#slide(composer: (1fr, 1fr))[
  *Traditional Approach*
  - Manual drawing tools
  - Pixel-based images
  - Hard to version control
  - Difficult to modify
  - Time-consuming iteration
][
  *AI-Assisted Approach*
  - Generate library code
  - Metadata-rich formats
  - Git-friendly text files
  - Easy modification
  - Rapid iteration
]


= Core Concept

== Library Code Generation

Instead of generating images directly, #redt[generate code] for figure libraries:

#pause

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  stroke: none,
  align: (left, left, left),
  [*Ecosystem*], [*Library*], [*Use Case*],
  table.hline(),
  [LaTeX], [TikZ], [Academic papers, precise diagrams],
  [Markdown], [Mermaid], [Documentation, flowcharts],
)

#pause

#v(1em)
*Key Insight*: Libraries encode structure and semantics, not just pixels.

== The Approach

#fletcher-diagram(
  node-stroke: .1em,
  spacing: (7em, 2em),

  node((0, 0), [Conceptual\ Description], radius: 3em, fill: blue.lighten(80%)),
  pause,
  edge((0, 0), (1, 0), [Structured\ Prompt], "-|>", label-side: center),
  node((1, 0), [LLM], radius: 2em, fill: green.lighten(80%)),
  pause,
  edge((1, 0), (2, 0), [Library\ Code], "-|>", label-side: center),
  node((2, 0), [Rendered\ Figure], radius: 2.5em, fill: orange.lighten(80%)),
)

#meanwhile

#v(1em)
The prompt contains #redt[constraints and best practices] specific to the target library.

= Prompt Engineering

== Key Components of a Good Prompt

Example from `figure-tikz.md` #footnote[https://github.com/jiahaoxiang2000/deeper-paper]:

#pause

```markdown
1. **Pure relative positioning only**
2. **NO anchor-based offsets** — avoid manual coordinates
3. **Simple paths**
4. **Row-based layout** — structure as logical rows
- `minimum width`: 1.4–2.2cm
- `node distance`: 0.5–0.7cm vertical
```

#pause

#greent[Prompt = Expert knowledge + Constraints + Anti-patterns]

== Prompt Structure

```markdown
You are a TikZ/LaTeX Expert.

## Design Principles
[Best practices and constraints]

## Required Libraries
[Dependencies to include]

## Code Structure Template
[Skeleton with style definitions]

## Robust Patterns
[Recommended approaches]

## Anti-Patterns to Avoid
[Common mistakes]

## Task
Create a TikZ figure for: $ARGUMENTS
```

#v(1em)
This structure works for #bluet[any figure library] (TikZ, Mermaid, CeTZ, etc.)

= Iterative Refinement

== Step 1: Generate Code

Use your structured prompt with the LLM to generate initial figure code.

#pause

*Example*: "Create a TikZ diagram showing data flow between three components"

#pause

→ LLM outputs TikZ code following your prompt's constraints


== Step 2: Evaluate Output

Compile and render the generated code to see the actual figure.

#pause

*Check for*:
- Does it match the conceptual design?
- Are sizes/spacing appropriate?
- Is the style consistent?
- Does it compile without errors?

#pause

If #greent[YES] → You're done! ✓

If #redt[NO] → Continue to next step...

== Step 3: Find Issues

Identify specific problems with the output:

#pause

#table(
  columns: (2fr, 3fr),
  stroke: none,
  align: (left, left),
  [*Issue Type*], [*Example*],
  table.hline(),
  [Layout], [Nodes overlap, poor alignment],
  [Sizing], [Too wide for column, text truncated],
  [Style], [Used absolute positioning, wrong colors],
  [Compilation], [Missing library, syntax error],
)

#pause

Each issue reveals a #redt[missing constraint] in your prompt.

== Step 4: Update Prompt

Refine the prompt based on issues found:


*Add constraints*:
```markdown
- Use relative positioning only (no xshift/yshift)
- Maximum width: 8.5cm for single column
- Node spacing: 0.6cm vertical, 1.8cm horizontal
```

#pause

*Add anti-patterns*:
```markdown
❌ Avoid: `above right=-0.1cm of node.south`
✅ Use: `below=of node` with separate row
```

== Step 5: Iterate

#align(center)[
  #box(
    fill: blue.lighten(90%),
    inset: 1.5em,
    radius: 0.5em,
    [
      #text(size: 1.2em)[
        Generate → Evaluate → Find Issues → Update Prompt
      ]
    ],
  )
]


Each issue discovered → prompt improvement → better future outputs

*Result*: A refined prompt that generates good figures consistently.


= Broader Context

== This Pattern Everywhere

The same #redt[prompt engineering] approach powers:

#pause

#table(
  columns: (2fr, 3fr),
  stroke: none,
  align: (left, left),
  [*Tool/System*], [*What It Does*],
  table.hline(),
  [Claude Code SKILLS], [Reusable expert prompts for coding tasks],
  [MCP Servers], [Structured interfaces for specific domains],
  [Custom Commands], [Domain-specific prompt templates],
)

#pause

#v(1em)
*Common thread*: #bluet[Encode expert knowledge in structured prompts]

== Why It Works

#slide(composer: (1fr, 1fr))[
  *Without Prompt Engineering*
  - Generic LLM output
  - Inconsistent style
  - May violate constraints
  - Requires manual fixes
  - Not reusable
][
  *With Prompt Engineering*
  - Expert-level output
  - Consistent patterns
  - Respects constraints
  - Ready to use
  - Reusable template
]


= Summary

== Key Takeaways

- #redt[Generate code, not pixels] for figures
- Use #bluet[structured prompts] with constraints and examples
- #greent[Iterate] to refine both output and prompt
- Apply to #oranget[any figure library] (TikZ, Mermaid, CeTZ, Fletcher)
- Same technique as #purplet[SKILLS and MCP servers]

#pause

#v(1em)
*Core insight*: Prompt engineering = Encoding expert knowledge

#pause

#v(1em)
#align(center)[
  #text(size: 1.2em, weight: "bold")[
    Quality of output ∝ Quality of prompt
  ]
]

== Resources

- Example TikZ prompt: \
  `github.com/jiahaoxiang2000/deeper-paper` \
  `.opencode/command/figure-tikz.md`

- Typst libraries:
  - CeTZ: `typst.app/universe/package/cetz`
  - Fletcher: `typst.app/universe/package/fletcher`

- LaTeX TikZ: `tikz.dev`

- Mermaid: `mermaid.js.org`
