
46. Popup Control
==

Custom popups, add subview above all views on screen. Custom popup control.


```objc
//CheckFinesController

@property (strong, nonatomic) SHGRegistrationPromptController *registrationPC;

- (void)setupRegistrationPrompt {

    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    self.registrationPC = [[SHGRegistrationPromptController alloc] initWithNibName:@"SHGRegistrationPromptView" bundle:nil];
    self.registrationPC.delegate = self;
    [currentWindow addSubview:_registrationPC.view];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.registrationPC.view setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    
    self.registrationPC.view.hidden = YES;
}

#pragma mark - SHGRegistrationPromptDelegate

- (void)registrationPromptControllerClosePressed {

    [UIView animateWithDuration:0.25 animations:^{
        self.registrationPC.view.alpha = 0;
    } completion: ^(BOOL finished) {
        self.registrationPC.view.hidden = YES;
    }];
}
```

```objc
//RegistrationPromptController.h

@protocol SHGRegistrationPromptDelegate <NSObject>

@optional
- (void)registrationPromptControllerClosePressed;
@end

@interface SHGRegistrationPromptController : UIViewController
@property (weak, nonatomic) id<SHGRegistrationPromptDelegate> delegate;
@end

```

```objc
//RegistrationPromptController.m

#import "SHGRegistrationPromptController.h"

@interface SHGRegistrationPromptController ()
@end

@implementation SHGRegistrationPromptController

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Events
- (IBAction)closeButtonWasPressed:(id)sender {
    [self closeController];
}

#pragma mark - Actions

- (void)closeController{
    if ([self.delegate respondsToSelector:@selector(registrationPromptControllerClosePressed)]) {
        [self.delegate registrationPromptControllerClosePressed];
    }
}

@end
```






