15. UIView. UIView with NIB.
==

## Custom View.

1. Создание класса - `SATourView : UIView.`
2. User Interface > `Empty.xib` или `View.xib`.
3. File's owner - `SATourView`.
4. Потом установка `Outlet-a UIView *view` - внутрь класса SATourView.
5. Потом `соединяем Outlet view c Owner's file`.

6. Устанавливаем constraints чтобы view-ха увеличивалась.

## SATourView

```objc
#import <UIKit/UIKit.h>

@interface SATourView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@end
```

```objc
#import "SATourView.h"

@implementation SATourView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 1. Load .xib
        
        // 2. Adjust bounds
        
        // 3. Add as a subview
        
        [[NSBundle mainBundle] loadNibNamed:@"SATourView" owner:self options:nil];
        
        NSLog(@"frame = %@", NSStringFromCGRect(self.view.bounds));
        NSLog(@"bounds = %@", NSStringFromCGRect(self.bounds));
        
        self.bounds = self.view.bounds;
        
        [self addSubview:self.view];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SATourView" owner:self options:nil];
        
        [self addSubview:self.view];
    }
    
    return self;
}

- (IBAction)joinButtonTapped:(id)sender {
    
    NSLog(@"joinButtonTapped");
}


@end
```

* Работа с SATourView внутри контроллера:

```objc
SATourView *view1 = [[SATourView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view1.bounds = self.view.bounds;
    view1.mainTitleLabel.text = @"Новый текст";
    
    [self.view addSubview:view1];
```



