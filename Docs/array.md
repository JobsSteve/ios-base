54. Array
==

## Check for nil and for empty

```objc
if (!array || !array.count) {
  ...
}

if (array == nil || [array count] == 0) {
    ...
}

```

`!array` - check for nil

`!array.count` - check for empty

That checks if array is not nil, and if not - check if it is not empty.







