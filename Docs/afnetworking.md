82. Networking. AFNetworking. AFNetworkActivityLogger.
==

## AFNetworkActivityLogger.

### Podfile

```objc
pod 'AFNetworking’, '~> 2.6.3’
pod 'AFNetworking+AutoRetry’, '~> 0.0.5’

pod 'AFNetworkActivityLogger', '~> 2.0.4'
```

### AFNetworkActivityLogger
```objc
//Network Logger
#import "AFNetworkActivityLogger.h"

[[AFNetworkActivityLogger sharedLogger] startLogging];
```

### Network Logging
```objc

NSLog(@"HEADERS = %@", self.manager.requestSerializer.HTTPRequestHeaders);
NSLog(@"PARAMS  = %@", params);
NSLog(@"RESPONSE: %@", jsonDict.debugDescription);
```


## Обертки для GET/POST запросов, Updload Data. (Request wrappers).

## Как проектировать класс для API запросов.

## Запросы в связке с NSOperationQueue.

## Запросы в связке с GCD.

## Асинхронные запросы.

## Повторяющиеся запросы. Отложенные запросы.

