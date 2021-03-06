82. Networking. AFNetworking. AFNetworkActivityLogger. App Transport Security.
==

## App Transport Security

C iOS9 появилось нововедение, связанное с тем что проект нужно настроить для работы с networking.

Внутри Info.plist добавляем поле `App Transport Security` > добавляем внуреннее поле `Allows Arbitrary Loads` > `YES`

Данная настройка отключает ограничения на работу с networking.

```objc
<key>NSAppTransportSecurity</key>
<dict>
  <!--Include to allow all connections (DANGER)-->
  <key>NSAllowsArbitraryLoads</key>
      <true/>
</dict>
```

__Как это будет выглядеть в Info.plist__

![ATS](https://github.com/arthurigberdin/ios-base/blob/master/Images/Adoptation/ats_info.png)

http://ste.vn/2015/06/10/configuring-app-transport-security-ios-9-osx-10-11/

## AFNetworkActivityLogger.

https://github.com/AFNetworking/AFNetworkActivityLogger

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

//Cтандартное включение логера
[[AFNetworkActivityLogger sharedLogger] startLogging];

//Только для вывода логов об ошибках
//If the default logging level is too verbose—say, if you only want to know when requests fail, then changing it is as simple as:
[[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelError];
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

