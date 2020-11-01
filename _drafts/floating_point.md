---
title:  "Floating point numbers: some basics"
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

Fixed point is a method of representing a real number by applying a fixed scaling to an integer value. To understand how to represent a number in fixed point, it's easiest to work through some examples.

To begin with, let's say we have 4 decimal digits to represent the number 1234:
<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td>10<sup>3</sup></td>
    <td>10<sup>2</sup></td>
    <td>10<sup>1</sup></td>
    <td>10<sup>0</sup></td>
</tr>
<tr><td>1</td><td>2</td><td>3</td><td>4</td></tr>
</table>
Using these digits, our number can be calculated as $$1\times10^3 + 2\times10^2 + 3\times10^1 + 4\times10^0 = 1234$$

If we add a decimal point in the middle, the units each digit represents changes and we end up with 12.34:
<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td>10<sup>1</sup></td>
    <td>10<sup>0</sup></td>
    <td>.</td>
    <td>10<sup>-1</sup></td>
    <td>10<sup>-2</sup></td>
</tr>
<tr><td>1</td><td>2</td><td>.</td><td>3</td><td>4</td></tr>
</table>
$$1\times10^1 + 2\times10^0 + 3\times10^{-1} + 4\times10^{-2} = 12.34$$

We haven't changed the number of digits that we need to store the number, but we've changed the way we interpret the digits so that the first two digits come before the decimal point and the last two digits come after. This is the same as applying a scaling factor of $$10^{-2}$$ or $$\frac{1}{100}$$ to the value when converting between the digits that we store in memory and the real numeric value. In the case of 1234, all 4 digits were before the decimal point and there were 0 digits after, and we would apply a scaling factor of $$10^0$$ or $$1$$.

Any scaling factor can be used for a fixed point number, but its common to use a scaling factor based on a power of 2 to simplify operations when working with these numbers on a computer. If we switch to powers of 2, then a fixed point number looks like this:

<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td>2<sup>1</sup></td>
    <td>2<sup>0</sup></td>
    <td>.</td>
    <td>2<sup>-1</sup></td>
    <td>2<sup>-2</sup></td>
</tr>
<tr><td>1</td><td>0</td><td>.</td><td>0</td><td>1</td></tr>
</table>
$$1\times2^1 + 0\times2^0 + 0\times2^{-1} + 1\times2^{-2} = 2.25$$

 There are [many ways](https://en.wikipedia.org/wiki/Fixed-point_arithmetic#Notation) to structure a fixed point number, each with their own notation. A common pattern is to describe a floating point value as `N.F`, where `N` is the number of integer digits and `F` is the number of fractional digits. In the example above, the format of 10.01 is `2.2`.

It's worth noting what happens to the fractional digits when converted to binary digits: each bit represents a power of two fraction. For a `1.8` format, each bit would take the following base 10 values:

<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td>2<sup>0</sup></td>
    <td>.</td>
    <td>2<sup>-1</sup></td>
    <td>2<sup>-2</sup></td>
    <td>2<sup>-3</sup></td>
    <td>2<sup>-4</sup></td>
    <td>2<sup>-5</sup></td>
    <td>2<sup>-6</sup></td>
    <td>2<sup>-7</sup></td>
    <td>2<sup>-8</sup></td>
</tr>
<tr>
    <td>1</td>
    <td>.</td>
    <td>1/2</td>
    <td>1/4</td>
    <td>1/8</td>
    <td>1/16</td>
    <td>1/32</td>
    <td>1/64</td>
    <td>1/128</td>
    <td>1/256</td>
</tr>
</table>

This presents accuracy issues when working with decimal values. Values like 0.5 or 0.75 can be represented exactly using this system, but the only way to represent a value like 0.3 is by approximation.

Arithmetic with fixed point values that share a common format is straightforward and can be performed using the same operations as integer values. To add two values, simply add the two underlying integer values together. To multiply two values, multiply the underlying integer values together and then multiply by the scaling factor.

When working with binary numbers, instead of a decimal point, the term **radix point** is used to refer to the separator that divides the integer and fractional parts of a number.

Floating point
==============

While fixed point is effective at representing real values, the fixed scaling factor can be limiting. For example, if constrained to 32 bits, an unsigned fixed point value stored in `16.16` format can only represent a maximum integer value of 65535. The only way to go beyond this range is to modify the number format.

Floating point builds upon fixed point by including a scaling factor along with the significant digits of the number. This makes it possible to represent both very large and very small values using a single type.

To do this, floating point makes use of [normalised scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) to represent a number. For example, the number 0.001267 becomes $$1.267\times10^{-3}$$ in normalised scientific notation. The number is broken down into two parts, the _mantissa_ of 1.267 and the _exponent_ of -3.

In normalized format, the mantissa, $$m$$, can be positive or negative, but must always be in the range $$ 1.0 \geq m < 10.0$$. The exponent is always represented as an integer value.

## Representing floating point values

As with the fixed point examples discussed above, floating point numbers are represented using base 2 numbers. This gives a normalized scientific notation format of $$ \pm m \times 2^{\pm e} $$, where $$m$$ is the mantissa in the range $$ 1.0 \geq m < 2.0$$ and $$e$$ is the exponent.

In terms of bits, a 32-bit floating point value (such as a C++ `float`) breaks down into the following parts:

| Sign    | Exponent | Mantissa     |
| ------- | -------- | ------------ |
| 1 bit   | 8 bits   | 23 bits      |

### Mantissa sign

The sign of the mantissa is represented by a single bit: 0 if positive and 1 if negative. Separating the sign bit results in the mantissa being stored as an unsigned value instead of requiring the use of two's complement arithmetic. Negation of the mantissa only requires the sign bit to be flipped and the absolute value of a number can be obtained by setting the sign bit to 0. This also makes floating point numbers symmetric: every positive value also has a corresponding negative one.

One side effect of this representation is that zero can be either negative or positive!

### Exponent

The exponent is stored as a _biased_ integer number. The stored value represents an offset which is subtracted from a constant bias value to give the value of the exponent. In the case of a `float` value, the value of 127 is used as a bias.

Given an exponent value $$E$$, it can be encoded into the stored value $$S$$ with a bias of $$B$$ using:

$$ \begin{equation}
S = E + B
\end{equation} $$

In theory, it should be possible to represent exponents in the range -127 to 128 but the values of -127 and 128 are reserved for special cases, giving a real range of -126 to 127. This gives an approximate base 10 range from $$2^{-126} = 1.2 \times 10^{-38}$$ to $$2^{127} = 1.7 \times 10^{38}$$.

### Mantissa

The mantissa is stored as a `1.23` fixed point number, but because we're storing the mantissa in normalised format in base 2, the first digit will always be $$1$$. Therefore, we don't need to store the first digit and instead only need to store the 23 fractional bits of the mantissa.

## Further reading

* Wikipedia's entry for [floating point](https://en.wikipedia.org/wiki/Floating-point_arithmetic) contains a lot of useful information and is worth a read.
* Intel published a fascinating article [Intel and Floating-Point](https://www.intel.com/content/dam/www/public/us/en/documents/case-studies/floating-point-case-study.pdf) which provides a history of the development of the IEEE Standard 754 for Binary Floating-point Arithmetic and the motivation behind it.

In my next post, I'll also describe some of the issues that can occur while working with floating point and how to avoid them.