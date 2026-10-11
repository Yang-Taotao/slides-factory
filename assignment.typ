// ================================================================================== //
// Example assignment template for physics/astrophysics/astronomy
// MIT (c) 2026 Taotao Yang
// ================================================================================== //
#import "assignment_template.typ": *

// ================================================================================== //
// 1. Title blocks
// ================================================================================== //
#show: template.with(
  title: "The assignment: this looks like a title",
  topic: "Very Difficult Course (VDC)",
  due:   "Jan. 01, 1970 by 23:59 hours",
  dated: "Jan. 01, 2000",
  authors: (
    (
      name: "James Holden",     
      email: "holden@roci.edu",  
      institution: "UNN University",
    ),
    (
      name: "Naomi Nagata",
      email: "nagata@roci.edu",   
      institution: "Ceres Academy",
    ),
    (
      name: "Amos Burton",   
      email: "burton@roci.edu",   
      institution: "Baltimore State University",
    ),
    (
      name: "Alex Kamal", 
      email: "kamal@roci.edu", 
      institution: "Mars Naval Academy",
    ),
  ),
  lecturers: (
    (
      name: "Dr. Praxideke Meng", 
      email: "pmeng@ganymede.org",
    ),
    (
      name: "Chrisjen Avasarala", 
      email: "avasarala@unn.gov",
    ),
  ),

  header-left:  "Very Difficult Course",
  header-right: "Assignment 42",

  // Font overrides — uncomment to use local fonts.
  // font:      ("Your Local font", "Liberation Serif"),
  // mono-font: ("Your Local mono font",  "Liberation Mono"),
  font: "Iosevka NFP",
  mono-font: "Iosevka NFM",
)

// ================================================================================== //
// 2. Front matter
// ================================================================================== //
#front-matter[
  #outline(title: [Table of Contents], depth: 1)
  #outline(title: [List of Figures],  target: figure.where(kind: image))
  #outline(title: [List of Tables],   target: figure.where(kind: table))
]

#pagebreak()

// ================================================================================== //
// 3. Main body
// ================================================================================== //
= Introduction <ch:intro>

This is an introduction chapter. We write these following similar syntax with `.md`.

```typ
= Chapter Title <ch:label>
== Section Title <sec:label>
=== Subsection Title <subsec:label>
```

== Math <sec:math>

This is a section. Cross-referenced with @sec:math or the chapter with @ch:intro.

=== Inline mathematics <subsec:inline-math>

Inline math can be written as `$E = m c^2$`, rendered as: $E = m c^2$. 
Note that there is no space between `$` and math content.
An inline integral is therefore `$integral_0^oo e^(-x^3) dif x$`.
This is then rendered as $integral_0^oo e^(-x^3) dif x$. 

We also write greek letters and some math symbols with subscripts in similar fashion.
We use `$alpha, beta, gamma$` for $alpha, beta, gamma$
A subscript can be written with `$T_"system"$` for $T_"system"$.

=== Display equations <subsec:equations>

A numbered and labelled equation:

$ a x^2 + b x + c = 0 $ <eq:quadratic>

An equation with cases:

$ f(x) = cases(
  1  & "if " x > 0,
  0  & "if " x = 0,
  -1 & "if " x < 0,
) 
$ <eq:cases>

A matrix equation:

$ bold(A) = mat(
  1, 2, 3;
  4, 5, 6;
  7, 8, 9;
) 
$ <eq:matrix>
=== Figures and tables <subsec:figs-tables>

A figure placed at the bottom of a page, shown in @fig:placeholder:

#figure(
  rect(width: 100%, height: 5cm, fill: luma(128), stroke: none)[
    #align(center + horizon)[Placeholder figure 1]
  ],
  caption: flex-caption(
    [
      Example figure but with a longer caption.
    ],
    [Example figure.],
  ),
  placement: bottom,
) <fig:placeholder>

A side-by-side figure placed at top of the page is created via `grid` in @fig:side-by-side.

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    rect(width: 100%, height: 5cm, fill: luma(128), stroke: none)[
      #align(center + horizon)[Placeholder figure 2-a]
    ],
    rect(width: 100%, height: 5cm, fill: luma(128), stroke: none)[
      #align(center + horizon)[Placeholder figure 2-b]
    ],
  ),
  caption: flex-caption(
    [
      Two placeholder panels demonstrating side-by-side layout.
      (a) Left figure is much wow.
      (b) Right figure is also wow.
    ],
    [Side-by-side placeholder figures.],
  ),
  placement: top,
) <fig:side-by-side>

=== Code listings <subsec:code>

Let us say that we want to include some python codes here.
This can be achieved by following:

````typ
```python
import numpy as np

def simple_fn(a, b):
    """simply return (a + b)"""
    return a+b

```
````

This subsequently renders into:

```python
import numpy as np

def simple_fn(a, b):
    """simply return (a + b)"""
    return a+b

```

=== Citations <subsec:cites>
We can cite with keys showsn in a `.bib` file.
The syntax is `@key`. 
A single entry with `item @key1` @key1. 
Multiple enteries as `item @key2 @key3` @key2 @key3.

== Problem and solution environments <sec:problem-solution>

#problem[
  What is the result of 1+1 in dec?
]

#solution[
  I believe this is 1+1=2.
]

== Adding appendix <sec:adding-appendix>

Appendix is initialized via `#show: appendix`.

== Print bibliography <sec:print-bib>

Print bibliography in a specific citation style from a `ref.bib` file with `#bibliography("ref.bib", style: "american-physics-society")`

// ================================================================================== //
// 4. Appendix
// ================================================================================== //
#show: appendix

= Code listing <app:code>

We list the codes from a code file:

#raw(read("code/example.py"), lang: "python", block: true)


// ================================================================================== //
// 5. Bibliography
// ================================================================================== //
#bibliography("ref.bib", style: "american-physics-society")
