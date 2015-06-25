5. AppDelegate. UIApplication. UIDevice.
==

### UIDevice

Get UUID
```objc
NSString *strUniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
```

### AppDelegate

```objc
Just Follow these steps

1.import your app delegate in your class where you want app delegate object.

#import "YourAppDelegate.h"
2.inside your class create an instance of your app delegate object(Its basically a singleton).

YourAppDelegate *appDelegate=( YourAppDelegate* )[UIApplication sharedApplication].delegate;
3.Now invoke method using selector

if([appDelegate respondsToSelector:@selector(yourMethod)]){

        [appDelegate yourMethod];
    }
or directly by

[appDelegate yourMethod];
i will recommend the first one. Run and Go.
```


