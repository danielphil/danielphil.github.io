---
title:  "Learning about Floating point numbers"
categories: Coding Floating Point
---

A recent discussion with a colleague about issues with floating point comparisons made me realise that my knowledge of best practices boiled down to comparing floating point values using tolerances and switching to `double` if issues with accuracy popped up. I figured it was time to look into it further and get a better understanding of what is actually going on.

* Why floating point? Representing real numbers vs integer, normalised scientific notation.
* Fixed point
* How to calculate errors in representation
* How floating point represents a number, bits, sign, mantissa, exponent
* Representing zero
* NaN
* Infinity
* Additions and subtractions. When they go wrong and catastrophic cancellation.
* multiplications
* Floating point types: single, double, half
* Floating point on Intel: FPU instructions and SSE
* Summary of best practices

https://www.intel.com/content/dam/www/public/us/en/documents/case-studies/floating-point-case-study.pdf