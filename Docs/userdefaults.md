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






