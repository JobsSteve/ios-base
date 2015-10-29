71. Mobile Statistics. Mixpanel. Appsflyer.
==

## Mixpanel

https://mixpanel.com/help/reference/ios

Основные метрики:
Cutomer retention - удержание пользователей.
Customer engagement - привлечение пользователей.

Track of the number of active users of an application - активные юзеры.

Вопросы:
Why feature is underused - почему фича не используется.


__1. Pod__
```
pod 'Mixpanel'
```

__2. Добавить библиотеку__
```
#import "Mixpanel.h"
```

__3. On launch__
```
#define MIXPANEL_TOKEN @"YOUR_TOKEN"

// Initialize the library with your
// Mixpanel project token, MIXPANEL_TOKEN
[Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];

// Later, you can get your instance with
Mixpanel *mixpanel = [Mixpanel sharedInstance];
```


* 3. Send events
```objc
Mixpanel *mixpanel = [Mixpanel sharedInstance];

[mixpanel track:@"Plan Selected" properties:@{
    @"Gender": @"Female",
    @"Plan": @"Premium"
}];
```

```objc
Mixpanel *mixpanel = [Mixpanel sharedInstance];

[mixpanel track:@"signup" properties:@{
    @"signup_button": @"test12",
    @"User Type": @"Paid"
}];
```




## Appsflyer




