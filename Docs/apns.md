35. Push notifications
==

## APNS - Apple Push Notification Service

Получение сообщения о каком-то важном действии (дверь в офис открыта, обед готов, получен ответ с сервисе).

Push-уведомление:
* 1. короткий текст
* 2. звуковой сигнал
* 3. номер бейджа на иконке

Cхема работы механики push-уведомлений:

* 1. Регистрация для получения push notifications.
* 2. iOs запрашивает токен девайса у APNS и получает токен девайса.
* 3. Приложение отправляет токен на сервер.
* 4. Когда произойдет `СОБЫТИЕ`, сервер отправит push notifications в APNS.

Фоновое выполнение - только для навигации, VOIP и воспроизведение звука.

Нужно создать SSL-сертификат.

payloads (полезная нагрузка).

Полезная назгрузка - это словарь(dictionary) который состоит по крайней мере из одной пары - ("ключ" - "значение").

## Дебаг Push notifications

https://pushbots.com (Сервис для проверки Push-уведомлений).

https://github.com/stefanhafeneger/PushMeBaby.

![PushMeBaby](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/pushmebaby.png).

## Настройка Provisioning Profiles и APNS Сертификатов.

APNS Production + Certificate.SigningRequest = aps_production.p12 (сертификат для сервера).

Создание APNS-сертификатов происходит внутри AppID - включается опция "push notifications".

## Проверка сертификата через PushBoats

* 1. Загрузить библиотеку через CocoaPods:
```objc
pod 'Pushbots'
```

* 2. В AppDelegate импортировать библиотеку:
```objc
#import <Pushbots/Pushbots.h>
```

* 3. На запуске приложения добавить:
```objc
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    //PUSHBOTS
    [Pushbots sharedInstanceWithAppId:@"562a0d441779591b668b4569"];
    [[Pushbots sharedInstance] receivedPush:launchOptions];
    
    return YES;
}
```

* 4. Добавить в методе регистрации Push notifications и получением токена.
```objc
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //PUSHBOTS
    [[Pushbots sharedInstance] registerOnPushbots:deviceToken];
}
```

* 5. В этом методе получаем Push notifications в виде словаря. 
```objc
- (void)application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLOG(@"Push Notification = %@", userInfo);
}
```


















