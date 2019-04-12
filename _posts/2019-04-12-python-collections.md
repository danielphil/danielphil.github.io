---
title:  "Python collection classes: a summary"
categories: Coding
---

Following on from the C++ collections post, it's time to create a similar overview page for Python! There are more collection classes than this, but I wanted to revise the basics.

Common features
===============

Common Python sequence operations are documented [here](https://docs.python.org/3/library/stdtypes.html#common-sequence-operations).

Overview
========

| [list](#list) | [array](#array) | [deque](#deque) |
| [set](#set) | [dict](#dict) | [stack](#stack) |
| [queue](#queue) | [tuple](#tuple) | |

<a name="list" />

[list](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
===========

A variable sized array where elements do not need to all be the same type. $$O(1)$$ to access an element, and $$O(1)$$ amortized for adding an element at the end.

```python
l = [3, 6, 34, 1]
for element in l:
    print(element)

print(l[2])

# add item to end
l.append(10)

# add multiple items to end
l.extend([9, 0, -1])

# insert at position 2
l.insert(2, 'string')

# remove item by value
l.remove(34)

# remove last item in list and return it
# pop can also take an index
print(l.pop()) # 1

# delete first element of the list
del l[0]

print(l) # [6, 'string', 1, 10, 9, 0]

# clear the contents of the list
copy = l.copy()
l.clear()
print(copy) # [6, 'string', 1, 10, 9, 0]
```

<a name="array" />

[array](https://docs.python.org/3/library/array.html)
==========

A list where all elements are constrained to be the same type. The interface for the array is very similar to that of a list.

```python
from array import array

# signed long array
a = array('l', [3, 4, 5, 6, 9])
```


<a name="deque" />

[deque](https://docs.python.org/3/library/collections.html#collections.deque)
========

Similar to a list, but provides approximately $$O(1)$$ performance for removal from the beginning or end of the list. The interface is similar to a list, but with a number of `left` functions to allow fast operations on the left of the deque.

```python
from collections import deque

d = deque([3, 6, 34, 1])
for element in d:
    print(element)

print(d.pop()) # 1
print(d.popleft()) # 3

d.append(-12)
d.appendleft(5)
print(d) # deque([5, 6, 34, -12])

d.extend([7, 7])
d.extendleft([2, 2])
print(d) # deque([2, 2, 5, 6, 34, -12, 7, 7])
```

<a name="set" />

[set](https://docs.python.org/3/library/stdtypes.html#set-types-set-frozenset)
========

An unordered set of unique elements. `set` is implemented using a hash table and provides $$O(1)$$ access to elements.

```python
s = { 2, 3, 4, 5, 5}
print(s) # {2, 3, 4, 5}

s = set([3, 2, 1, 2])
print(s) # {1, 2, 3}
print(0 in s) # False
print(3 in s) # True

s.remove(2)
print(s) # {1, 3}
```

<a name="dict" />

[dict](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict)
=========

Associative containers that hold key-value pairs. `dict` is $$O(1)$$ for insertion, removal and search.

```python
d = { 'day': 'Tuesday', 10: 123 }
for key, value in d.items():
    print('{}: {}'.format(key, value))

# default iterator is over keys
for key in d:
    print(key)

del d['day']
print(d) # {10: 123}
```

<a name="stack" />

stack
============

Stacks can be implemented in Python using a list.

```python
stack = []
# append == push
stack.append(10)
stack.append(12)
print(stack.pop()) # 12
```

<a name="queue" />

queue
=========

Queues can be implemented efficiently using a deque.

```python
from collections import deque

queue = deque()
# append == enqueue
queue.append(12)
queue.append(24)

# popleft == dequeue
print(queue.popleft()) # 12
```

<a name="tuple" />

[tuple](https://docs.python.org/3/library/stdtypes.html#tuples)
============

Tuples are immutable sequences. They can be used as keys for a dict and also can be unpacked easily. `namedtuple` also allows the elements of the tuple to be assigned names.

```python
from collections import namedtuple

t = (1, 2, 3)
a, b, c = t
print('a: {} b: {} c: {}'.format(a, b, c))

Test = namedtuple('Test', ['a', 'b'])
t2 = Test(4, 5)
print(t2.a) # 4
```