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