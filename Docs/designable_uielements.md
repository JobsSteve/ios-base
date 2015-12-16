Designable UI Elements: Attributed View, Attributed Button, etc.
==

## Attributed View, Attributed Image View (тоже самое)

Interface
```objc
//IB_DESIGNABLE
@interface DTAttributedView : UIView //UIImageView

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
```

Implementation
```objc
#import "DTAttributedView.h"

@implementation DTAttributedView

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

## Attributed Button

Interface
```objc
//IB_DESIGNABLE
@interface DTAttributedUIButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
```

Implementation
```objc
#import "DTAttributedUIButton.h"

//Categories
#import "UIImage+FromUIColor.h"

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




