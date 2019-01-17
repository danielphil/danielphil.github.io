---
title:  "Notes from Codility lessons"
categories: Coding
---

[Codility](https://www.codility.com) has a number of [lessons online](https://app.codility.com/programmers/lessons/) to help candidates prepare for the problems on the site. I figured it might be worthwhile to make a summary of some of the algorithms from the lessons that I more easily forget.

# Prefix (and suffix) sums

Makes it easy to calculate totals for slices of an array. Codility provides the following algorithm:
```python
def prefix_sums(A):
    n = len(A)
    P = [0] * (n + 1)
    for k in range(1, n + 1):
        P[k] = P[k - 1] + A[k - 1]
    return P
```
Note that the first element is `0` with this algorithm.

The sum of the elements in a slice from `x` to `y` can be calculated using `P[y + 1] - P[x]`.

# Leader of an array
The leader of an array is the element that occurs more than $$\frac{n}{2}$$ times in the array. Codility provides the following $$O(n)$$ solution for this:
```python
def goldenLeader(A):
    n = len(A)
    size = 0
    # keep a 'stack' of leaders to find a potential candidate
    for k in xrange(n):
        if (size == 0):
            size += 1
            value = A[k]
        else:
            if (value != A[k]):
                size -= 1
            else:
                size += 1

    # validate that the candidate is actually the leader    
    candidate = -1
    if (size > 0):
        candidate = value
    leader = -1
    count = 0
    for k in range(n):
        if (A[k] == candidate):
            count += 1

    if(count > n // 2):
        leader = candidate

    # returns -1 if no leader was found
    return leader
```

# Maximum slice
Finds the slice with the largest sum. Codility provides an implementation of [Kadane's algorithm](https://en.wikipedia.org/wiki/Maximum_subarray_problem#Kadane's_algorithm) for this problem:
```python
def golden_max_slice(A):
    max_ending = max_slice = 0
    for a in A:
        max_ending = max(0, max_ending + a)
        max_slice = max(max_slice, max_ending)
    return max_slice
```
Initialisation doesn't have to start from 0 and Wikipedia has more information on variations of the algorithm.

# Counting divisors of $$n$$
Codility provides an algorithm that can count divisors of $$n$$ in $$O(\sqrt{n})$$. It relies on finding symmetric divisors, which allows you to count two divisors for the price of one.
```python
def divisors(n):
    i = 1
    result = 0
    # iterate up to sqrt(n)
    while (i * i < n):
        if (n % i == 0):
            result += 2
        i += 1
    # if i^2 == n, then we count an extra divisor
    if (i * i == n):
        result += 1
    return result
```

## Checking for prime numbers
Based on the same principles as the example above, you can check for primes by iterating over `i * i <= n`. If `n % i == 0`, then the number isn't prime.

## Sieve of Eratosthenes

Can be used to find all prime numbers in the range $$2$$ to $$n$$.

Here's [an implementation](https://github.com/danielphil/codility_training/blob/master/sieve.py) based on Codility's notes.

Some quick reminders:
* Need a list of flags for each number from `2` to `n`.
* Main loop iterates from 2 to $$\sqrt{n}$$ (inclusive). Not necessary to iterate all the way to `n`.
* Each time the main loop is incremented, if the flag for the current value `i` indicates it is still prime:
    1. Mark $$i^2$$ as non prime.
    2. Mark $$i^2 + i$$ as non prime.
    3. Continue marking multiples as non prime until reaching `n`.
* At the end, all prime numbers will have been found.
* Complexity is $$O(n\log{\log{n}})$$.

### Finding prime factors

The Sieve of Eratosthenes algorithm can be modified to find the prime factors of a number `n`.
1. Build an array `F` of minimum prime factor for each value of `i` instead of just using `true/false`.
2. Iterate through this array starting at element `n`.
3. Store the prime factor at position `F[n]` in the output list of prime factors.
4. `n = n / F[n]`
5. Keep iterating until `F[n] == 0`

Complexity is $$O(\log{n})$$.

See here for [an implementation](https://github.com/danielphil/codility_training/blob/master/sieve.py) based on Codility's notes.

### Euclidean algorithm

The Codility notes provide 3 approaches for finding the greatest common divisor (**gcd**) between 2 numbers:
* **Euclidean algorithm by subtraction:** recursively subtract the larger value from the smaller until the values are equal. $$O(n)$$
* **Euclidean algorithm by division:** recursively use the modulo operator until the two values are divisible by each other. $$O(\log(a + b))$$ where $$a$$ and $$b$$ are the two input values.
* **Binary Euclidean algorithm:** a more complex implementation involving division by 2 and scaling the result. $$O(\log{n})$$

The least common multiple (**lcm**) of $$a$$ and $$b$$ is the smallest value that can be divided by $$a$$ and $$b$$.

$$lcm(a, b) = \frac{a \cdot b}{gcd(a, b)}$$

See here for [an implementation](https://github.com/danielphil/codility_training/blob/master/euclidean.py) based on Codility's notes.

### Fibonacci numbers

```python
def fib(n):
    fib = [0] * (n + 2)
    fib[1] = 1

    for i in range(2, n + 1):
        fib[i] = fib[n - 1] + fib[n - 2]
    
    return fib[n]
```

Complexity is $$O(n)$$.

### Binary search

Start with a sorted list of values `v`, length `n`. `beg = 0`, `end = n - 1`, $$ { mid = \lfloor\frac{beg + end}{2}}\rfloor $$. Compare the value of `v[mid]` to `x`, and set `beg` or `end` to `mid ± 1` depending on the value. Keep repeating until `x` has been found (or can't be found).

Complexity is $$O(\log{n})$$.