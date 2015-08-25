Fonts-Tests
==

1. Добавить папку с Fonts в `project navigator`.

2. `Info.plist` -> Fonts provided in application (добавить item-ы)

3. Target -> `Copy Bundles Resource`s (добавить файлы)

4. Метод для `определения названия шрифтов` (чтобы использовать в коде):

```objc
for (NSString* family in [UIFont familyNames]) {
    NSLog(@"%@", family);
    for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
        NSLog(@"  %@", name);
    }
}
```


5. Альтернатива, добавление через `CoreText`

```objc
//Fonts
#import <CoreText/CoreText.h>
#import <MobileCoreServices/MobileCoreServices.h>

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
```

