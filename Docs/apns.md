35. Push notifications
==

## APNS - Apple Push Notification Service

Получение сообщения о каком-то важном действии (дверь в офис открыта, обед готов, получен ответ с сервисе).

Push-уведомление:
* 1. короткий текст
* 2. звуковой сигнал
* 3. номер бейджа на иконке

Cхема работы механики push-нотификации:
* 1. Регистрация для получения push-нотификаций.
* 2. iOs запрашивает токен девайса у APNS и получает токен девайса.
* 3. Приложение отправляет токен на сервер.
* 4. Когда произойдет `СОБЫТИЕ`, сервер отправит push-нотификацию в APNS.

Фоновое выполнение - только для навигации, VOIP и воспроизведение звука.

Нужно создать SSL-сертификат.

payloads (полезная нагрузка).

`Полезная назгрузка` - это словарь(dictionary) который состоит по крайней мере из одной пары - ("ключ" - "значение").

## Дебаг Push notifications

## Плохие и хорошие кейсы использовать пуш-нотификации

http://blog.goodbarber.com/The-Right-and-Wrong-Way-to-Use-Push-Notifications_a431.html

https://pushbots.com (Сервис для проверки Push-уведомлений).

https://github.com/stefanhafeneger/PushMeBaby.

![PushMeBaby](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/pushmebaby.png).

## Настройка Provisioning Profiles и APNS Сертификатов.

1. APNS Production + Certificate.SigningRequest =
2. = aps_production.p12 
3. отдаем этот сертификат.p12 для сервера (или берем с сервера чтобы `проверить сертификат.p12 на валидность`)
4. отправляем на сервер токен (`добавление девайса`) и сертификат.p12 + токен = 
5. = позволяет отправлять адресованный push-нотификации.

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

## iOS 8 & iPhone 6 No Push Notifications Appearing

На iOS 8 можно получать пуши без отображения.


## Какие сертификаты отдавать серверному программисту.

Всегда отдавать на сервер Production.p12 поскольку на fabric-у отправляется релиз версия, которая принимает именно такой сертификат.

*Классическая ошибка серверного разработчика* - отправляет пуш на Development.p12 сертификат и никто его не получает.

## Как обновить APNS сертификат, если он истек?

1. войти на `developer.apple.com` >
2. войти в главный сертификат напр: `Company LLC` > 
3. нажать на `+` и добавить новый `ANPS сертификат` >
4. далее выбрать `App ID` для которого будет создан новый сертификат.

После того, как обновили APNS нужно поменять provision profile.


## Обнуление бейджа иконки при активировании приложения

If your app becomes active again and is still in the background you should reset the badge count in `-applicationDidBecomeActive:` as well:
```
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
}
```
If your app is still running in the background `-application:didFinishLaunchingWithOptions:` won't be called.


## Получение DeviceID для управление какие push-токен удалить, а какие добавить

```objc
UIDevice *device = [UIDevice currentDevice];
NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
```


## Можно ли передавать через пуш-нотификацию - id-шники.




### Как перевести бинарник пуш-токена из NSString обратно в NSData

```objc
NSString *device = @"<1ab78242 b77f5522 9986cc72 a2a01fc7 167d9fd1 66500d3e 9fe074db 26d685e7>";
const char *ptr = [device cStringUsingEncoding:NSUTF8StringEncoding];
NSMutableData *data = [NSMutableData data];
    
   while (*ptr) {
        unsigned char c1 = *ptr;
        ptr++;
        if (isalpha(c1))
            c1 = (10 + c1 - 'a')<<4;
        else if (isnumber(c1))
            c1 = (c1 - '0')<<4;
        else
            continue;
        if (!*ptr)
            break; // Shouldn't occure -- bad input
        unsigned char c2 = *ptr;
        ptr++;
        if (isalpha(c2))
            c2 = 10 + c2 - 'a';
        else if (isnumber(c2))
            c2 = c2 - '0';
        c1 = c1 | c2;
        [data appendBytes:&c1 length:1];
    }
    
    //Где это может понадобиться
    //[[Pushbots sharedInstance] registerOnPushbots:[data copy]];
```


## Вопросы:

1. Может ли не работать APNS для отправки пушей если на сервере много невалидных девайс токенов? (Тоесть сервер замусорен девайс токенами).
2. Как автоматизировать получение пуша на Development.p12 сертификат, если сервер отправляет только на Production.p12 сертификат?
3. Как на сервера выкидывать из базы неактивные девайс токены (пуш-токены)?



















