---
title:  "Wordsearch puzzle generator"
image:
    path: /images/900x1_transparent.png
    thumbnail: /images/wordsearch/screenshot.png
comments: false
---

<figure style="width: 283px" class="align-right">
  <img src="{{ '/images/wordsearch/full_screenshot.png' | absolute_url }}" alt="">
  <figcaption>An example wordsearch generated with the tool.</figcaption>
</figure> 

I've been interested in writing a [wordsearch](https://en.wikipedia.org/wiki/Word_search) puzzle generator for a while, but never managed to get around to it. However, my wife was recently complaining that it was hard to find tools for generating these puzzles online for her classes that weren't riddled with irritating popup ads, so I thought it would be interesting to bash something together.

The completed puzzle generator can be found at [https://danielphil.github.io/wordsearch/](https://danielphil.github.io/wordsearch/). The tool can generate a puzzle based on a user-provided word list and difficulty can be adjusted by changing the grid size and supported directions for words. The solution (without random characters) can be viewed for any generated puzzle and the UI is hidden when printing, making it easy to generate puzzle handouts.

Development
=========

[GitHub Pages](https://pages.github.com) makes it really easy to get content from a Git reposititory hosted online, so I tend to create little tools like this as web applications and leave all the dynamic functionality to the browser. The core wordsearch functionality is written using [TypeScript](https://www.typescriptlang.org) as I find the type checking makes it much easier to work with the code once it grows. I failed to find a way to seed the default JavaScript random number generator, so I made use of the [seedrandom](https://github.com/davidbau/seedrandom) library to allow the use of constant seeds for testing. TypeScript code and dependencies were packaged into a single JS file using [Webpack](https://webpack.js.org) that I could then reference from the static HTML.

I wanted to bash the frontend together quickly to get the project released, so I went with the most basic approach of a single HTML page with some inline JS for calling the wordsearch library. Yet again, [Bootstrap](https://getbootstrap.com) comes in handy for making programmer developed websites look a bit more polished. Bootstrap's handy `d-print-none` class made it super easy to set up the print layout to stop the form elements from being shown when the page was printed.

Source code and more information can be found on the [project GitHub page](https://github.com/danielphil/wordsearch).