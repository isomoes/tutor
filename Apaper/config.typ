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

// Set Chinese fonts for the presentation
// If the fonts are not installed, you can find new fonts to replace them. by the `typst fonts`.
// #set text(
//   font: (
//     "Noto Sans CJK SC", // Primary Chinese font
//     "Noto Serif CJK SC", // Alternative Chinese serif font
//     "WenQuanYi Micro Hei", // Chinese fallback font
//     "FZShuSong-Z01", // Traditional Chinese font
//     "HYZhongSongJ", // Another Chinese font option
//     "Noto Sans", // Latin fallback
//     "Roboto", // Final fallback
//   ),
//   // lang: "zh",
//   // region: "cn",
// )

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Additional font customization options:
// For headings, you can use a different font:
#show heading: set text(font: "Noto Serif CJK SC", weight: "bold")
// For code blocks, you can use a monospace font:
#show raw: set text(font: "Noto Sans Mono CJK SC")

#show: simple-theme.with(aspect-ratio: "16-9", footer: [APaper Env - v1.\*])

#title-slide[
  = APaper Env Config SetUp
  #v(2em)

  isomo #footnote[github/jiahaoxiang2000]

  #v(2em)
  #datetime.today().display()
]

= Overview

== APaper Architecture

// The APaper architecture diagram: The researcher uses Copilot Chat to input questions or ideas. All information is then sent to the LLM module (e.g., Claude, Gemini, or OpenAI). In Agent mode, the LLM automatically plans the next steps, with each step involving calls to specific MCP function tools. The Chat input and MCP tools can be customized. The goal of the APaper project is to enable the LLM to generate more relevant and accurate content for paper creation. By leveraging the LLM's reasoning abilities, APaper reduces human effort on low-complexity tasks and makes the paper creation process more efficient.
#fletcher-diagram(
  node-stroke: .1em,
  spacing: 1.5em,
  // Nodes
  node((-2, 0), `Researcher`, radius: 2.3em),
  edge((-2, 0), (0, 0), `input `, "--|>"),
  pause,
  node((0, 0), `Chat Mode`, radius: 2.5em, fill: blue),
  edge((0, 0), (2, 0), ``, "-|>"),
  pause,
  node((2, 0), `LLM Module`, radius: 2.5em),
  pause,
  node((5, 0), `Tools`, radius: 2em, fill: blue),
  edge((2, 0), (5, 0), `Call`, "-|>", bend: -40deg),
  edge((5, 0), (2, 0), `Result`, "-|>", bend: -40deg),
)

#meanwhile

#bluet[Blue fill: _APaper Configure Points_]


= Env SetUp

== Tools (All in MCP) - install

MCP (Module Context Protocol) is support the *tools* for LLM module.

#pause

We publish the Package on the pypi.org#footnote[https://pypi.org/project/all-in-mcp/], So use the `pip install all-in-mcp` to install the MCP tools.

#pause

_Recommender:_

- use the *UV*#footnote[https://github.com/astral-sh/uv] to create the virtual environment `uv venv`
- and use the `uv pip install all-in-mcp` to install the MCP tools.

== Tools work with VS Code

- enter the Vscode command palette (Ctrl + Shift + P) #pause
- type `MCP: Add Server`, chose `Pip Package` and input `all-in-mcp` #pause
- allow the package by our email address, named MCP Server #pause
- _Recommender_ select store to workspace setting #pause
- it will create the `.vscode/mcp.json` file in your workspace

#pagebreak()
#alternatives[
  _Default_
  ```json .vscode/mcp.json
  {
    "servers": {
      "all-in-mcp": {
        "command": "uv",
        "args": ["run", "all-in-mcp"],
        "cwd": "/path/to/all-in-mcp" // not use `uv venv` command
      }
    }
  }
  ```][
  _Recommender_
  ```json .vscode/mcp.json
  {
    "servers": {
      "all-in-mcp": {
        "command": "uv",
        "args": ["run", "all-in-mcp"] // used `uv venv` command
      }
    }
  }
  ```
]

== Chat Mode (Option)

- Predefine _Chat Prompt_ on the `.github/prompts/*.prompt.md` file
  - To constraint LLM behavior, e.g., _output latex format_ #pause
- Predefine _Chat Mode_ on the `.github/chatmodes/*.chatmode.md` file
  - To constraint what _tools_ can be used, e.g., only use `search` tool


= Thanks Everyone

Enjoy the *_APaper_* 😃!
