Fonts.
==

## Add Custom Fonts to project

1. Add Fonts to Project (Кинуть шрифты в проект). и уже можно смотреть на симуляторе.

2. Добавить в Info.plist
`Fonts provided by Application` > `font-name.otf` и т.д.

3. Check system names of the fonts 

```objc
for (NSString* family in [UIFont familyNames]) {
    NSLog(@"%@", family);
    for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
        NSLog(@"  %@", name);
    }
}
```

## Load Custom Fonts (Загружае шрифты в проект программно)

__!!!Существует метаморфоза связанная с тем, что кастомные шрифты могут пропадать в проекте.__

Добавить библиотеки в проект:

`CoreText.framework`
`MobileCoreServices.framework`

```objc
//Import Libs
#import <CoreText/CoreText.h>
#import <MobileCoreServices/MobileCoreServices.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Загружаем шрифты в проект
    [self loadCustomFonts];
    return YES;
}

- (void)loadCustomFonts {

    // Load custom fonts
    CTFontManagerRegisterFontsForURLs((__bridge CFArrayRef)((^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
        NSArray *resourceURLs = [fileManager contentsOfDirectoryAtURL:resourceURL includingPropertiesForKeys:nil options:0 error:nil];
        return [resourceURLs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSURL *url, NSDictionary *bindings) {
            CFStringRef pathExtension = (__bridge CFStringRef)[url pathExtension];
            NSArray *allIdentifiers = (__bridge_transfer NSArray *)UTTypeCreateAllIdentifiersForTag(kUTTagClassFilenameExtension, pathExtension, CFSTR("public.font"));
            if (![allIdentifiers count]) {
                return NO;
            }
            CFStringRef utType = (__bridge CFStringRef)[allIdentifiers lastObject];
            return (!CFStringHasPrefix(utType, CFSTR("dyn.")) && UTTypeConformsTo(utType, CFSTR("public.font")));
            
        }]];
    })()), kCTFontManagerScopeProcess, nil);
    
    //Проверка загруженных шрифтов (поиск шрифта по имени)
    for (NSString* family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
            NSLog(@"  %@", name);
        }
    }
}
```



