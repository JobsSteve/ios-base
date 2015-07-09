5. ViewController. Popups. Pass data between controllers. Perform Segues.
==

## Navigation Controller

###Pass data from Navigation Controller.

```objc
MyViewController * myVC = [[MyViewController alloc] initWithNibName:nil bundle:nil];
myVC.someProperty = someValue;    // Pass your data here
[self.navigationController pushViewController:myVC animated:YES];
And in your MyViewController class :

.h

@interface MyViewController : UIViewController
@property (nonatomic, strong) NSString * someProperty;
@end

.m

@implementation MyViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        // your data has been set
        // self.someProperty is equal to "some value"
    }
```

### Remove previous controller from Stack

```objc
- (void)removePreviousController
{
    NSMutableArray *navigationStack = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    [navigationStack removeObjectAtIndex:[navigationStack count] - 2];
    self.navigationController.viewControllers = navigationStack;
}
```


## Popups

```objc
- (void)setupRegistrationPrompt
{
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    self.registrationPC = [[SHGRegistrationPromptController alloc] initWithNibName:@"SHGRegistrationPromptView" bundle:nil];
    self.registrationPC.delegate = self;
    [currentWindow addSubview:_registrationPC.view];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.registrationPC.view setFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    
    self.registrationPC.view.hidden = YES;
}
```

## Perform Segues

```objc

//Сегвей м/у контроллерами
SettingsToTourSegue

//Константа
static NSString *const kDTSettingsToTourSegue = @"SettingsToTourSegue";

//Вызов сегвея
[self performSegueWithIdentifier:kDTSettingsToTourSegue sender:self];

#pragma mark - Navigation

//Передача параметров
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:kDTSettingsToProfileSegue]) {
        DTProfileViewController *vc = [segue destinationViewController];
        vc.user = [DTApi instance].currentUser;
    }
    
    if ([[segue identifier] isEqualToString:kDTSettingsToProfileSegue]) {
        DTVideoPresentationViewController *vc = [segue destinationViewController];
        vc.hidesBottomBarWhenPushed = YES;
        
        //vc.user = [DTApi instance].currentUser;
    }
}
```


