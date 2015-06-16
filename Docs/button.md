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

* Кейворды: IB_DESIGNABLE и IBInspectable.

```objc
//  DTAttributedUIButton.h
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SHGAttributedButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end

//  DTAttributedUIButton.m
#import "DTAttributedUIButton.h"

@implementation DTAttributedUIButton

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
