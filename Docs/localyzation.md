
57. Localization.
===

## Как подключать:
http://code.tutsplus.com/tutorials/ios-sdk-localization-with-nslocalizedstring--mobile-11603

1. Добавляем в `info.plist` - Localizations: en, ru. 

2. Добавить `Strings File` New->File->Strings File (из Resources)

3. Назвать их как (`ru.strings` и `en.strings`)

4. Выбрать `Project` (not Target) и во вкладке `Info` в секции `Localizations` + to `French(fr)`


## Кейсы:
1. Кейс - что делать с русским языком.

2. Кейс - как установить язык по умолчанию.



## Проверка локализации на устройстве.

If `language` is returning other values such a "fr-FR" and "fr-CA", then you should split `language` on the `-` character. This will work even you simply get "fr".

    NSString *firstLanguage = [[NSLocale preferredLanguages] firstObject];
    NSString *language = [[firstLanguage componentsSeparatedByString:@"-"] firstObject];
    if ([language isEqualToString:@"fr"]) {
    } else {
    }

## Проверка версий.

При загрузке поверх - если версия поменялася с 1.1 до 1.1.1 то обнуляем настройки.

```objc
- (NSString *)appNameAndVersionNumberDisplayString {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@, Version %@ (%@)",
            appDisplayName, majorVersion, minorVersion];
}
```

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

## Установка языка при первом запуске

```objc
NSString *language = [[LANGUAGE componentsSeparatedByString:@"-"] firstObject];
    BOOL isEnglish = [language isEqualToString:@"en"];
    BOOL isRussian = [language isEqualToString:@"ru"];
    
    if (isRussian == NO && isEnglish == NO) {
        language = @"en";
    }
    
    NSLog(@"Перепроверяем язык телефона: %@", language);
    
    if (![[JHUserDefaultHelper sharedInstance] getIsSeconLaunch]) {
        [[JHUserDefaultHelper sharedInstance] setAppLanguage:language];
        [[JHUserDefaultHelper sharedInstance] setAppCurrency:EUR];
        [[JHUserDefaultHelper sharedInstance] setIsSeconLaunch:YES];
        [[JHUserDefaultHelper sharedInstance] setUserPhone:@"temp"];
    }
```

## Скрипт инкрементирования номера билда.

Код/Скрипт который на каждом новом запуске билда меняет номер билда













