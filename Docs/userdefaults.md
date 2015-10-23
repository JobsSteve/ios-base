44. User Defaults. Helper class. Logic.
==

## Если новая версия (обнуляем первый запуск и сбрасываем настройки)

```objc
//Проверка версии чтобы изменить настройки (обнулить первый запуск) если версия новая
    NSString *currentAppVersion = [self appVersionDisplayString];
    NSString *oldAppVersion = [[JHUserDefaultHelper sharedInstance] getAppVersion];

    BOOL versionIsChanged = ![currentAppVersion isEqualToString:oldAppVersion];
    if (versionIsChanged == YES) {
        [[JHUserDefaultHelper sharedInstance] setIsSeconLaunch:NO];
        [[JHUserDefaultHelper sharedInstance] setAppVersion:currentAppVersion];
    }
```

## Если девайс-токен изменился. Методы для AIPushService

```objc
//При получении девайс-токена (сохраняем как текущий токен)
- (void)saveCurrentTokenInDefault {
    [[NSUserDefaults standartDefaults] setObject: token ForKey: @"CurrentDeviceToken"];
}
 
//При выходе из аккаунта (удаляем девайс-токен из сервера)
 [self deleteTokenFromServer];
 
//При удалении приложения (удаляем девайс-токен из сервера)
 [self deleteTokenFromServer];

//Проверяем насчет изменения токена
- (BOOL) tokenDidChanged {
   NSString *oldToken = [[NSUserDefaults standartDefaults] objectForKey:@"DeviceToken"];
   NSString *currentToken = [[NSUserDefaults standartDefaults] objectForKey:@"CurrentDeviceToken"];
   BOOL tokenIsChanged = ![currentToken isEqualToString:oldToken];
   
   return tokenIsChanged;
}
   
//Добавляем токен на сервер или меняем девайс-токен на сервере (если токен изменился)
- (void)addTokenToServer {
    
    if (tokenIsChanged == YES) {
        [self deleteTokenFromServer];
        [[NSUserDefaults standartDefaults] setObject: currentToken ForKey: @"DeviceToken"];
        [self addTokenToServer];
    } else {
        [self addTokenToServer];
    }
}
```

## Когда меняется девайс-токен

If the user restores backup data to a new device or reinstalls the operating system, the device token changes.

## Переход в нужный экран (контроллер), когда открываем push-нотификацию

Структура push-нотификации:







