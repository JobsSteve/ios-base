82. Networking. AFNetworking. AFNetworkActivityLogger.
==

## AFNetworkActivityLogger.


### Podfile

```objc
pod 'AFNetworking’, '~> 2.6.3’
pod 'AFNetworking+AutoRetry’, '~> 0.0.5’

pod 'AFNetworkActivityLogger', '~> 2.0.4'
```

### Network Logger

```objc
//Network Logger
#import "AFNetworkActivityLogger.h"


[[AFNetworkActivityLogger sharedLogger] startLogging];
```
