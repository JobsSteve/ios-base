12. Tools. Классы Helpers.
==

## AIRAppTheme
Tools - AppTheme для работы с темами: (цвета и шрифты).

```objc
@interface AIRAppTheme : NSObject

+(AIRAppTheme *)shared;

-(UIFont *)appFont;
-(UIColor *)blueBackgroundColor;
-(UIColor *)grayBackgroundColor;
-(UIColor *)deviderColor;
-(UIColor *)mainTextColor;
-(UIColor *)backgroundTextColor;
-(UIColor *)searchTextColor;
-(UIColor *)borderColor;
-(UIColor *)grayBorderColor;
-(UIColor *)blueBorderrColor;
-(UIColor *)lightGrayColor;
-(UIColor *)listGrayColor;
-(UIFont *)eventDescriptionFont;
@end
```

```
#import "FTGAppTheme.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FTGAppTheme ()
@end

@implementation FTGAppTheme

+ (instancetype)shared {
    static FTGAppTheme *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [FTGAppTheme new];
    });
    return _shared;
}

#pragma mark - Colors

-(UIColor *)blueBackgroundColor {
    return UIColorFromRGB(0x42b1eb);
}

-(UIColor *)grayBackgroundColor {
    return UIColorFromRGB(0xeff1f3);
}

-(UIColor *)deviderColor {
    return UIColorFromRGB(0xb4b4b4);
}

-(UIColor *)mainTextColor {
    return UIColorFromRGB(0x5e5e5e);
}

-(UIColor *)backgroundTextColor {
    return UIColorFromRGB(0xf4f6f8);
}

-(UIColor*)searchTextColor {
    return UIColorFromRGB(0x2487c6);
}

-(UIColor*)borderColor {
    return UIColorFromRGB(0xd2d2d2);
}

-(UIColor *)grayBorderColor {
    return UIColorFromRGB(0xdadbdd);
}

-(UIColor *)blueBorderrColor {
    return UIColorFromRGB(0xa6daf6);
}

-(UIColor *)lightGrayColor {
    return UIColorFromRGB(0xeeeeee);
}

-(UIColor *)listGrayColor {
    return UIColorFromRGB(0xdee0e2);
}

#pragma mark - Fonts

-(UIFont *) eventDescriptionFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
}

-(UIFont*)appFont {
    return [UIFont fontWithName:@"Arial" size:14];
}

@end
```

### Работа с AIRAppTheme

```objc
[FTGAppTheme shared] blueBackgroundColor]
[_loadButton setBackgroundColor:[[FTGAppTheme shared] grayBackgroundColor]];
```





