---
title:  "C++ collection classes: a summary"
categories: Coding
---

As I work through a bunch of algorithm problems in C++, I thought it would be useful to create a summary of the collection classes built into the standard library.

Common features
===============

In general, most collections support:
* Getting the number of elements in the collection with `size()`.
* Iteration with `begin()` and `end()`.
* Checking if the collection is empty with `empty()`.

Overview
========

| [std::array](#array) | [std::vector](#vector) | [std::deque](#deque) |
| [std::forward_list](#forward_list) | [std::list](#list) | [std::set](#set) |
| [std::unordered_set](#set) | [std::multiset](#multiset) | [std::unordered_multiset](#multiset) |
| [std::map](#map) | [std::unordered_map](#map) | [std::stack](#stack) |
| [std::queue](#queue) | [std::priority_queue](#priority_queue) ||

<a name="array" />

[std::array](https://en.cppreference.com/w/cpp/container/array)
==========

A fixed size array with all elements of the same type. $$O(1)$$ to access an element.

```cpp
#include <iostream>
#include <array>

int main() {
    std::array<int, 5> a = {1, 2, 3, 4, 5};
    for (auto i : a) {
        std::cout << i << std::endl;
    }
    
    // not range checked
    std::cout << a[4] << std::endl;
    
    // range checked
    std::cout << a.at(4) << std::endl;
}
```

<a name="vector" />

[std::vector](https://en.cppreference.com/w/cpp/container/vector)
===========

A variable sized array. $$O(1)$$ to access an element, and $$O(1)$$ amortized for adding an element at the end.

```cpp
#include <iostream>
#include <vector>

int main() {
    std::vector<int> a = {1, 2, 3, 4, 5};
    a.push_back(10);
    
    for (auto i : a) {
        std::cout << i << std::endl;
    }
    
    a.clear();
    std::cout << a.size() << std::endl;
}
```
<a name="deque" />

[std::deque](https://en.cppreference.com/w/cpp/container/deque)
========

An indexed sequence container that allows fast deletion and insertion at the beginning and end of the sequence.
* $$O(1)$$ to access an element.
* $$O(1)$$ to insert or remove an element at the start or end of the array.
* $$O(n)$$ to insert or remove elements at other locations.

```cpp
#include <iostream>
#include <deque>

int main() {
    std::deque<int> a = {1, 2, 3, 4, 5};
    a.push_back(6);
    a.push_front(12);
    
    for (auto i : a) {
        std::cout << i << std::endl;
    }
    
    std::cout << a[2] << std::endl;
    
    a.clear();
    std::cout << a.size() << std::endl;
}
```

<a name="forward_list" />

[std::forward_list](https://en.cppreference.com/w/cpp/container/forward_list)
=========

A singly-linked list.

```cpp
#include <iostream>
#include <forward_list>

int main() {
    std::forward_list<int> list;
    
    auto next = list.insert_after(list.before_begin(), 10);
    next = list.insert_after(next, 12);
    list.push_front(20);
    
    for (auto i : list) {
        std::cout << i << std::endl;
    }
}
```

<a name="list" />

[std::list](https://en.cppreference.com/w/cpp/container/list)
=======

A doubly-linked list.

```cpp
#include <iostream>
#include <list>

int main() {
    std::list<int> list;
    
    auto next = list.insert(list.begin(), 10);
    next = list.insert(next, 12);
    list.push_front(20);
    
    for (auto i : list) {
        std::cout << i << std::endl;
    }
}
```

<a name="set" />

[std::set](https://en.cppreference.com/w/cpp/container/set) and [std::unordered_set](https://en.cppreference.com/w/cpp/container/unordered_set)
========

A set of unique elements. `set` is $$O(\log{n})$$ for insertion, removal and search and provides elements in sorted order, whereas `unordered_set` is $$O(1)$$ and uses hashing to store elements.

```cpp
#include <iostream>
#include <set>
#include <unordered_set>

int main() {
    std::set<int> s = { 2, 7, 3, 1, 6 };
    std::unordered_set<int> u = { 2, 7, 3, 1, 6 };
    
    // returns 1 2 3 6 7
    for (auto i : s) {
        std::cout << i << std::endl;
    }
    // returns 6 1 3 7 2
    for (auto i : u) {
        std::cout << i << std::endl;
    }
    
    bool contains_8 = s.find(8) == s.end();
}
```

<a name="multiset" />

[std::multiset](https://en.cppreference.com/w/cpp/container/multiset) and [std::unordered_multiset](https://en.cppreference.com/w/cpp/container/unordered_multiset)
============

A set of elements that supports adding duplicate elements. `multiset` is $$O(\log{n})$$ for insertion, removal and search and provides elements in sorted order, whereas `unordered_multiset` is $$O(1)$$ and uses hashing to store elements.

```cpp
#include <iostream>
#include <set>
#include <unordered_set>

int main() {
    std::multiset<int> s = { 2, 7, 3, 1, 2, 6, 2 };
    std::unordered_multiset<int> u = { 2, 7, 3, 1, 2, 6, 2 };
    
    // returns 1 2 2 2 3 6 7
    for (auto i : s) {
        std::cout << i << std::endl;
    }
    // returns 6 1 3 7 2 2 2
    for (auto i : u) {
        std::cout << i << std::endl;
    }
    
    const auto pair = s.equal_range(2);
    const int count = std::distance(pair.first, pair.second);
    // Item count: 3
    std::cout << "Item count: " << count << std::endl;
}
```

<a name="map" />

[std::map](https://en.cppreference.com/w/cpp/container/map) and [std::unordered_map](https://en.cppreference.com/w/cpp/container/unordered_map)
=========

Associative containers that hold key-value pairs. `map` is $$O(\log{n})$$ for insertion, removal and search and provides elements in sorted order, whereas `unordered_map` has $$O(1)$$ and uses hashing to store keys.

```cpp
#include <iostream>
#include <map>
#include <unordered_map>

template<typename Key, typename Value>
void print_pair(const std::pair<Key, Value>& pair) {
    std::cout << "(" << pair.first << ", " << pair.second
        << ")" << std::endl;
}

int main() {
    std::map<std::string, int> m = {
        { "d", 10 }, { "a", 25 }, { "c", 13 }
    };
    std::unordered_map<std::string, int> u = {
        { "d", 10 }, { "a", 25 }, { "c", 13 }
    };
    
    // (a, 25) (c, 13) (d, 10)
    for (auto pair : m) {
        print_pair(pair);
    }
    // (c, 13) (a, 25) (d, 10)
    for (auto pair : u) {
        print_pair(pair);
    }
    
    // 13
    std::cout << m["c"] << std::endl;
}
```

As with `set`, there also exists `multimap` and `unordered_multimap` which allow multiple keys with the same value.

<a name="stack" />

[std::stack](https://en.cppreference.com/w/cpp/container/stack)
============

A container wrapper that provides stack (LIFO) functionality.

```cpp
#include <iostream>
#include <stack>

int main() {
    std::stack<int> s;
    
    s.push(10);
    s.push(12);
    s.push(6);
    
    // 6
    std::cout << s.top() << std::endl;
    
    s.pop();
    // 12
    std::cout << s.top() << std::endl;
}
```

<a name="queue" />

[std::queue](https://en.cppreference.com/w/cpp/container/queue)
=========

A container wrapper that provides queue (FIFO) functionality.

```cpp
#include <iostream>
#include <queue>

int main() {
    std::queue<int> q;
    
    q.push(10);
    q.push(12);
    q.push(6);
    
    // 6
    std::cout << q.front() << std::endl;
    
    q.pop();
    // 12
    std::cout << q.front() << std::endl;
}
```

<a name="priority_queue" />

[std::priority_queue](https://en.cppreference.com/w/cpp/container/priority_queue)
============

Heap data structure that provides $$O(1)$$ lookup of the largest (by default) element, but $$O(\log{n})$$ insertion and removal.

```cpp
#include <iostream>
#include <queue>

int main() {
    std::vector<int> elements = { 5, 1, 54, 100 };
    std::priority_queue<int> max_heap(elements.begin(), elements.end());
    
    // 100
    std::cout << max_heap.top() << std::endl;
    
    using min_priority = std::priority_queue<int, std::vector<int>, std::greater<int>>;
    min_priority min_heap(elements.begin(), elements.end());
    
    // 1
    std::cout << min_heap.top() << std::endl;
}
```