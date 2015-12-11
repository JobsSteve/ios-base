79. Custom View. Designable View with XIB. Вьюха настраиваемая через IB.
==

## Draggable View

### XIB

XIB настраивается как:

__New File__ > __User Interface__ > __ View__ > Далее внутри XIB-файла где __File's Owner__ > __DraggableView__ (к примеру)

### Класс

```objc
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DraggableView : UIView

@property (nonatomic, assign) IBInspectable NSInteger cornerRadius;

@end
```
```
#import "DraggableView.h"

@interface DraggableView ()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation DraggableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self load];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
    }
    return self;
}

- (void)load {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"DraggableView" owner:self options:nil] firstObject];
    view.frame = self.bounds;
    
    [self addSubview:view];
    
    self.leftLabel.text = @"works";
    self.rightLabel.text = @"done :)";
}

- (void)setCornerRadius:(NSInteger)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

@end
```

