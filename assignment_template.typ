// ================================================================================== //
// An assignment template for physics/astronomy/astrophysics
// MIT (c) 2026 Taotao Yang
// ================================================================================== //

// ================================================================================== //
// Nord-light scheme
// ================================================================================== //
#let nord = (
  bg:       rgb("#FFFFFF"),
  fg:       rgb("#2E3440"),
  comment:  rgb("#5E81AC"),
  keyword:  rgb("#BF616A"),
  string:   rgb("#A3BE8C"),
  number:   rgb("#B48EAD"),
  operator: rgb("#D08770"),
)

// ================================================================================== //
// Default font stacks
// ================================================================================== //
#let default-font = (
  "Liberation Serif", "DejaVu Serif", "Times New Roman", "Georgia", "serif",
)
#let default-mono-font = (
  "Liberation Mono", "DejaVu Sans Mono", "Consolas", "Courier New", "monospace",
)

// ================================================================================== //
// Problem and Solution environments
// ================================================================================== //
#let problem-counter = counter("problem")

#let problem(body) = {
  problem-counter.step()
  context {
    let n = problem-counter.get().first()
    block(
      breakable: true,
      above: 1.2em,
      below: 0.6em,
      [*Problem #n.* ] + body,
    )
  }
}

#let solution(body) = block(
  breakable: true,
  above: 0.6em,
  below: 1.2em,
  [*Solution.* ] + body,
)

// ================================================================================== //
// Figures with long and short captions
// ================================================================================== //
#let in-outline = state("in-outline", false)

#let flex-caption(long, short) = context {
  if in-outline.get() { short } else { long }
}

// ================================================================================== //
// Front-matter mode
// ================================================================================== //
// Squash toc and lists of fig and tab without pagebreak
// Suppresses "pagebreak before level-1 heading" while true

#let front-matter-mode = state("front-matter-mode", false)

#let front-matter(body) = {
  front-matter-mode.update(true)
  body
  front-matter-mode.update(false)
}

// ================================================================================== //
// Appendix mode
// ================================================================================== //
#let appendix(body) = {
  set heading(numbering: "A.1.1")
  counter(heading).update(0)
  body
}

// ================================================================================== //
// Listing mode
// ================================================================================== //
#let listing(
  path,
  lang: "python",
  caption: none,
  supplement: "Listing",
  placement: auto,
) = {
  let body = raw(read(path), lang: lang, block: true)
  if caption == none {
    body
  } else {
    figure(
      kind: raw,
      supplement: supplement,
      caption: caption,
      placement: placement,
      body,
    )
  }
}

// ================================================================================== //
// Main template
// ================================================================================== //
#let template(
  title: none,
  topic: none,
  due: none,
  dated: none,
  authors: (),
  lecturers: (),
  header-left:  none,
  header-right: none,
  font:      none,
  mono-font: none,
  body,
) = {
  let font-stack      = if font      == none { default-font      } else { font }
  let mono-font-stack = if mono-font == none { default-mono-font } else { mono-font }

  // Doc metadata
  set document(
    title: if title == none { "" } else { title },
    author: authors.map(a => a.at("name", default: "")),
  )

  // Page setup
  set page(
    paper: "a4",
    margin: 1in,
    header: context {
      let p = counter(page).get().first()
      if p > 1 and (header-left != none or header-right != none) {
        grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          text(size: 9.5pt)[#if header-left  != none { header-left  } else { [] }],
          [],
          text(size: 9.5pt)[#if header-right != none { header-right } else { [] }],
        )
        v(-0.4em)
        line(length: 100%, stroke: 0.3pt)
      }
    },
    footer: context {
      let p = counter(page).get().first()
      if p > 1 {
        align(center, text(size: 9.5pt)[#p])
      }
    },
  )

  // Typography
  set text(font: font-stack, size: 11pt)
  set par(justify: true, leading: 0.65em)
  set math.equation(numbering: "(1)")

  // header numbering
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    context {
      if front-matter-mode.get() { it } else { pagebreak(weak: true); it }
    }
  }

  show outline.entry.where(level: 1): it => { v(0.4em, weak: true); it }

  // Add short captions to outline
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  // code listing style
  show raw.where(block: true): it => {
    set text(font: mono-font-stack, size: 9pt)
    block(
      width: 100%,
      inset: 8pt,
      radius: 2pt,
      stroke: (left: 2pt + nord.fg),
      fill: luma(250),
      it,
    )
  }

  // Tighten spacing around listing figures.
  show figure.where(kind: raw): set block(above: 1em, below: 1em)

  // Left-aligned fig captions
  show figure.caption: set align(left)

  // Title block
  block(width: 100%, {
    text(size: 16pt, weight: "bold")[
      #if title != none { title } else { [Untitled] }
    ]
    v(0.3em)
    line(length: 100%, stroke: 0.8pt)
    v(0.5em)

    grid(
      columns: (auto, auto, auto),
      row-gutter: 0.5em,
      column-gutter: 3em,
      align: (left, left, left),

      [*Topic:*], [#if topic != none { topic } else { [] }], [],
      [*Due:*],   [#if due   != none { due   } else { [] }], [],

      ..authors.enumerate().map(((i, a)) => (
        if i == 0 { [*Author:*] } else { [] },
        [#a.at("name", default: "")],
        if "email" in a { link("mailto:" + a.email)[#a.email] } else { [] },
      )).flatten(),

      ..lecturers.enumerate().map(((i, l)) => (
        if i == 0 { [*Lecturer:*] } else { [] },
        [#l.at("name", default: "")],
        if "email" in l { link("mailto:" + l.email)[#l.email] } else { [] },
      )).flatten(),

      [*Dated:*], [#if dated != none { dated } else { [] }], [],
    )

    v(0.5em)
    line(length: 100%, stroke: 0.8pt)
  })

  // Main body
  body
}