---
title:  "Issues with floating point"
categories: Coding FloatingPoint
---

Floating point values normally just work, but there are a few issues with them that are useful to be aware of! My [previous post]({% post_url 2020-10-31-floating-point-basics %}) discussed the representation of values, but this one will talk more about the times where things might not work quite as expected. I'm aiming for this to be a practical guide with some simple rules to follow, rather than an exhaustive study into all the issues with floating point.

Perhaps the most important thing to note about floating point is that relies on approximations to work with real numbers. If you don't require 100% accuracy, then floating point will generally be fine, but it's not the right thing to use if you require complete accuracy.

## Simple decimal values cannot be stored precisely in floating point

I'm repeating something that was mentioned in the earlier post, but it's worth saying again! Floating point uses power of 2 fractions to represent mantissa values, so it's not possible to store all decimal real numbers with complete accuracy.

For example, in Python 3, 0.3 really looks like this:
```
>>> format(0.3, '.60g') 
'0.299999999999999988897769753748434595763683319091796875'
```

And calculations that look simple when working with decimal digits don't always work as well in floating point:

```
>>> 0.5 - 0.3 - 0.05
0.15000000000000002
```

This issue is caused simply because floating point fractional digits need to be represented using powers of 2, so you'll get the same problem even when using higher precisions types like `double`. It's the same problem with trying to represent some fractions as a base-10, such as $$\frac{1}{3} = 0.3333333...$$

## Be careful with comparisons

Following on from the previous point, you generally don't want to compare floating point values exactly.

You can compare constant values exactly and get the result you expect:
```
>>> 0.15 == 0.15
True
```

But if you perform any calculations, there's probably a good chance that exact comparisons will fail.
```
>>> 0.5 - 0.3 - 0.05 == 0.15
False
```

To compare a calculated value against a known value, it's better to calculate the error. The most straightforward method is to calculate the absolute error. If the absolute error is small, then you can effectively treat the numbers as equal.

$$ \begin{equation}
Absolute Error = |Value - Expected|
\end{equation} $$

Absolute error isn't great as a general purpose method for comparing floating point numbers though. Increasing the exponent of a floating point number also increases the size of the smallest value that can be represented and hence increases the absolute error.

| Exponent | Smallest value         |
| -------- | ---------------------- |
| -126     | 1.401298464324817e-45  |
| -20      | 1.1368683772161603e-13 |
| 0        | 1.1920928955078125e-07 |
| 20       | 0.125                  |
| 127      | 2.028240960365167e31   |

In this case, it's better to use the relative error because it calculates the error in proportion to the size of the expected value. This accounts for the bigger absolute error between values as the exponent grows and makes for more stable comparisons.

$$ \begin{equation}
Relative Error = |\frac{Value - Expected}{Expected}|
\end{equation} $$

Python 3 includes the function [`math.isclose()`](https://docs.python.org/3/library/math.html#math.isclose) which is a useful tool if you want to compare floating point values as it takes both relative and absolute values into account.

## NaN

Floating point uses NaN to represent the result of computations that have no representable value. For example, the following C++ code will set `result` to NaN:
```
float result = 0.0f / 0.0f;
```

Once a value has been set to NaN, any future operations on that value will also result in NaN. The value has been lost and instead has effectively become an error code. Be sure to validate the operations that you're performing to check that you're not generating NaNs accidentally.

Also be careful to filter out NaN values when sorting floating point numbers. For example, Java's [`Double.compareTo()`](https://docs.oracle.com/javase/7/docs/api/java/lang/Double.html) considers NaN greater than positive infinity, which will result in all NaNs being first in a list of sorted doubles!

## Infinity

Infinity is generated when a floating point value exceeds the range of valid values for that type. There are both positive and negative infinity values. The following C++ code will generate a positive infinity value:
```
float result = 3e38f * 10;
```

Like NaN, infinity is a special value that affects all subsequent computations. Once you have an infinity value, subsequent operations on that value will also generate infinity. One easy workaround when encountering infinity values is to switch to a larger type like `double` instead of `float`.

## Addition and subtraction

Addition or subtraction of two floating point numbers $$A$$ and $$B$$ requires the radix points of the two values to be aligned. This is already the case if the two numbers have the same exponent, but if not, the value with the smaller exponent needs the mantissa to be shifted to the right by $$E_{larger} - E_{smaller}$$ bits. Note that this this operation results in the smaller value becoming denormalised.

Once the radix points of the two values are aligned, the mantissa bits can simply be added together as with fixed point values. The exponent of the result is based on $$E_{larger}$$, although it may be necessary to adjust this to ensure that the result is correctly normalised.

Subtraction works using a similar process, but if the result is much smaller than either of the input values, then zeros will be shifted into the mantissa value from the right until the result is properly normalised.

### Issues

Issues can occur when adding or subtracting floating point numbers that differ significantly in magnitude. The mantissa bits of the smaller value need to be shifted to align radix points with the larger value and this can result in the loss of all significant bits from the smaller value.

For example, let's say we want to calculate $$A + B$$ where $$A = 1.01_2\times2^{10}$$ and $$B = 1.11_2\times2^{2}$$. To show this more clearly, let's restrict the mantissa to 5 bits.

The mantissas for both values look like this before addition:
<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td><b>A</b></td>
    <td>1</td>
    <td>.</td>
    <td>0</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
</tr>
<tr>
    <td><b>B</b></td>
    <td>1</td>
    <td>.</td>
    <td>1</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
</tr>
</table>

However, to add the two values together we need to align the radix points of the two mantissas by $$E_{larger} - E_{smaller} = 10 - 2 = 8$$ bits. This is accomplished by shifting $$B$$ by 8 bits to the right, which results in the mantissa values below:
<table border="1" style="width: 100px; margin-left:auto; margin-right:auto;">
<tr>
    <td><b>A</b></td>
    <td>1</td>
    <td>.</td>
    <td>0</td>
    <td>1</td>
    <td>0</td>
    <td>0</td>
</tr>
<tr>
    <td><b>B</b></td>
    <td>0</td>
    <td>.</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
</tr>
</table>

The difference in exponents between the two values has resulted in $$B$$ becoming 0, so we've effectively been left with $$A + 0$$!

Another issue exists when subtracting two floating point values that are almost equal. This will produce a very small result after subtraction and zeros will need to be shifted in from the right to normalise the number. Any representation error in the number that existed before subtraction will be greatly increased by this process.

In summary, be careful when using addition and subtraction with numbers that differ significantly in magnitude, or subtraction of two large numbers where you depend on the accuracy of a small result.

## Summary

In summary, here are some things to bear in mind when you're working with floating point:

* Floating point is an approximation and many decimal values cannot be represented exactly. Don't use floating point if an exact representation is required!
* Make sure to use absolute and relative comparisons (such as Python's [`math.isclose()`](https://docs.python.org/3/library/math.html#math.isclose)) instead of exact comparisons when you need to compare floating point values.
* Beware of NaN and Infinity values when performing calculations.
* Avoid addition or subtraction of values that differ significantly in magnitude as this can give unexpected behaviour or large errors.