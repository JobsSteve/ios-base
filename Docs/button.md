38. Custom Button
==

## 1. Кастомная кнопка - SHGRedButton
```objc
//
//  SHGRedButton.m
//  CustomTextField-Tests
//
//  Created by Artur on 30/05/15.
//  Copyright (c) 2015 Artur Igberdin. All rights reserved.
//

#import "SHGRedButton.h"

//Categories
#import "UIColor+AppColors.h"

@implementation SHGRedButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    // Custom drawing methods
    if (self) {
        [self drawButton];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setupBigButton];
    }
    return self;
}

- (void)drawButton
{
    CALayer *layer = self.layer;
    layer.cornerRadius = 1.5;
    layer.borderWidth = 0.5;
    layer.borderColor = [UIColor grayColor].CGColor;
    
    //background
    layer.backgroundColor = [UIColor redButtonColor].CGColor;
    
    //shadow
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 0.5;
    layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

#pragma mark - Setups

- (void)setupLittleButton
{
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
}

- (void)setupBigButton
{
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:15];
}

#pragma mark - Actions

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted == YES) {
        self.layer.backgroundColor = [UIColor darkRedButtonColor].CGColor;
    }
    else {
        self.layer.backgroundColor = [UIColor redButtonColor].CGColor;
    }
}

//- (void)setSelected:(BOOL)selected
//{
//    if (selected == YES) {
//        //self.layer.borderColor = [UIColor redButtonColor].CGColor;
//        self.layer.backgroundColor = [UIColor lightButtonColor].CGColor;
//    }
//    else {
//        //self.layer.borderColor = [UIColor darkGrayColor].CGColor;
//        self.layer.backgroundColor = [UIColor redButtonColor].CGColor;
//    }
//}

@end
```

### Как использовать
```objc
//@interface ViewController ()
@property (weak, nonatomic) IBOutlet SHGRedButton *checkFinesButton;
@property (weak, nonatomic) IBOutlet SHGRedButton *orderButton;

//- (void)viewDidLoad 
[self.orderButton setupLittleButton];
```

## 2. Кастомизация кнопки через IB (Interface Builder).

http://www.appcoda.com/ibdesignable-ibinspectable-tutorial/

https://www.weheartswift.com/make-awesome-ui-components-ios-8-using-swift-xcode-6/

* Кейворды: IB_DESIGNABLE и IBInspectable.

* Этот код позволяет менять: цвет рамки, ширину рамки и радиус рамки внутри IB (Shows Attributes Inspector).

```objc
//  SHGAttributedButton.h
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SHGAttributedButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end

//  SHGAttributedButton.m
#import "SHGAttributedButton.h"

@implementation SHGAttributedButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setProperties];
    }
    return self;
}

- (void)setProperties {
    self.clipsToBounds = YES;
}

- (void)setBorderColor:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

@end

```

### IBInspectable valid types

```objc
Int
CGFloat
Double
String
Bool
CGPoint
CGSize
CGRect
UIColor
UIImage
```


``` Higlighted button
You can override UIButton :

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = UIColorFromRGB(0x387038);
    }
    else {
        self.backgroundColor = UIColorFromRGB(0x5bb75b);
    }
}

Create a method macro like:

  #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
and use as:

 self.backgroundColor = UIColorFromRGB(0X90EE90);

```
