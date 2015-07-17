2. Code Organization. Pragmas. Imports. Markers. Warnings.
==

##Pragmas

![Pragmas](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/pragmas.png)

`Control-6` - Show Document Items

## Markers

Also there is a lot of options like:
```
// FIXME: Midhun 

// ???: Midhun 

// !!!: Midhun 

// MARK: Midhun

// FIX: Everything crashes all the time 
```

Example:
```objc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: Return count of forecast
    return 0;
}
```

## Warnings

Example of use:
```
#warning Clean up this code after testing
```

