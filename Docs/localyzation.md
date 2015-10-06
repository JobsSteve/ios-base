
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
















