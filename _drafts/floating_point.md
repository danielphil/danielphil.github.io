---
title:  "Learning about Floating point numbers"
categories: Coding FloatingPoint
---

A recent discussion with a colleague about issues with floating point comparisons made me realise that my knowledge of best practices boiled down to comparing floating point values using tolerances and switching to `double` if issues with accuracy popped up. I figured it was time to look into it further and get a better understanding of what is actually going on.

Integers
========

Storing integer values exactly on a computer is pretty straightforward. Each integer type (`short`, `int`, `long`) provides a fixed number of bits to store a value. As long as your integer remains in the range of supported values, then it can be represented exactly.

Given $$n$$ bits, you can calculate the range of unsigned integers that can be represented using $$\eqref{unsigned_bits}$$.

$$ \begin{equation}
\begin{split}
\text{max} = 2^n - 1 \\
\text{min} = 0
\end{split} \label{unsigned_bits}
\end{equation} $$

For signed integers using [two's complement](https://en.wikipedia.org/wiki/Two%27s_complement), you can calculate the range using $$\eqref{signed_bits}$$.

$$ \begin{equation}
\begin{split}
\text{max} = 2^{n - 1} - 1 \\
\text{min} = -2^{n - 1}
\end{split} \label{signed_bits}
\end{equation} $$

Here's some examples of the ranges you have available based on the number of bits you have:

| Type    | bits | unsigned min | unsigned max  | signed min     | signed max    |
| ------- | ---- | ------------ | ------------- | -------------- | ------------- |
| `byte`  | 8    | 0            | 255           | -128           | 127           |
| `short` | 16   | 0            | 65,535        | -32,768        | 32,767        |
| `int`   | 32   | 0            | 4,294,967,295 | -2,147,483,648 | 2,147,483,647 |
| `long`  | 64   | 0            | 1.844e19      | -9.223e18      | 9.223e18      |

Once you get into `long` territory, the numbers become so big that I had to round them to fit them into the table. Rest assured that all the values in range can still be represented exactly!

Real numbers and fixed point
============================

While integers are useful, we also need to be able to represent real numbers to make it possible for us to store fractional values such as $$\pi$$, 23.43 and -0.3333. This is more complicated because there's an infinite set of real numbers that can be represented within a range. For example, the range 0 to 1 for an integer consists of just 0 and 1, but when we move to real numbers there's no limit to the number of values it can contain: 0, 1, 0.5, 0.125, 0.127, 0.96443324, etc. This often results in storing approximations of values instead of being able to represent their exact value.

One technique for storing real numbers is **fixed point**. This is a simpler technique than floating point and was commonly used on systems that lacked hardware support for floating point. For example, [Doom used fixed point representations](https://doomwiki.org/wiki/Fixed_point) for numbers because floating point hardware was not commonplace on systems at the time it was developed. The original Sony PlayStation hardware also relied on fixed point for calculations in the GTE coprocessor because it was cheaper to implement than full floating point hardware.




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