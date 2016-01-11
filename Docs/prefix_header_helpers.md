6. Prefix Header. Set .pch file and helpers/macroses.
==

## Зачем нужен?

Prefix header file - содержимое файла считывается препроцессором и ускоряется компилятором во всем скоупе программы.

В этом файл импортируются библиотеки которые используются часто и добавляются макросы которые используются часто.

## Установка Project-Prefix.pch.

1. Make new file: `⌘cmd+N`
2. iOS/Mac > Other > PCH File > `Project-Prefix.pch`.
3. Project > Build Settings > Search: "Prefix Header".
4. Under "Apple LLVM 6.0" you will get the Prefix Header key.
5. Type in: "ProjectName/Project-Prefix.pch".
6. Clean project: `⌘cmd+⇧shift+K`
7. Build project: `⌘cmd+B`

Путь для Project-Prefix.pch: `MyProject/Resources/Project-Prefix.pch`

![Prefix Header](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/prefix_header.png)

## Константы и хелперы в Project-Prefix.pch

Helpers in .pch file.

```objc
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//#define MR_SHORTHAND
#import <CoreData+MagicalRecord.h>
#endif

#define BUNDLE_ID [NSBundle mainBundle].bundleIdentifier
```

### Block Safe

```objc
//Не стоит это использовать, поскольку если падает приложение - найти ошибку во вложенных блоках проще
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil
```

### Debug Log

```objc
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
```

### RGB

```objc
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
```
