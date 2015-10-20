
Root TabBarController.
==

## Singleton Root TabBarController

```objc

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DTTabBarStyle) {
    DTTabBarStyleTransparent = 0,
    DTTabBarStyleGray = 1
};

@interface DTRootTabBarController : UITabBarController

+ (DTRootTabBarController *)instance;

/*
 Setup different styles of tab bar
 */
- (void)setTabBarStyle:(DTTabBarStyle)tabBarStyle;

/*
 New messages icon
 */
- (void)setupNewMessages;

- (void)HideBar:(BOOL)hidden;

@end

```

```objc
#import "DTRootTabBarController.h"

@interface DTRootTabBarController ()

@end

@implementation DTRootTabBarController

#pragma mark - View lifecycle

static DTRootTabBarController *_instance;
+ (DTRootTabBarController *)instance {
    return _instance;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _instance = self;
    [self configureTabBar];
}

- (void)configureTabBar {
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    //SELECTED COLOR
    self.tabBar.tintColor = [UIColor whiteColor];
    
    //BACKGROUND
    UIImage* tabBarBackground = [UIImage imageNamed:@"BarRect"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    //SECLECTED ITEM BACKGROUND
    CGFloat height = self.tabBar.frame.size.height;
    CGFloat width = self.tabBar.frame.size.width;
    
    UIImage *normalImage = [UIImage imageNamed:@"TabBarRed"];
    UIImage *scaledImage = [normalImage scaleToSize:CGSizeMake(width/3, height*1.01)];
    [[UITabBar appearance] setSelectionIndicatorImage:scaledImage];
    
    //SHADOW
    [[UITabBar appearance] setShadowImage:[UIImage imageWithUIColor:[UIColor clearColor]]];
    
    //ITEMS
    [item0 setImage:[[UIImage imageNamed:@"TabBarFeed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item0 setSelectedImage:[[UIImage imageNamed:@"TabBarFeedSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item1 setImage:[[UIImage imageNamed:@"TabBarMessages"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"TabBarMessagesSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item2 setImage:[[UIImage imageNamed:@"TabBarSettings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setSelectedImage:[[UIImage imageNamed:@"TabBarSettingsSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //IMAGE INSETS
    //tabBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //tabBarItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //tabBarItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

- (void)setTabBarStyle:(DTTabBarStyle)tabBarStyle {
    
    switch (tabBarStyle) {
        case DTTabBarStyleTransparent: {
            //BACKGROUND
            UIImage* tabBarBackground = [UIImage imageNamed:@"BarRect"];
            [self.tabBar setBackgroundImage:tabBarBackground];
            
            //TRANSLUCENT
            self.tabBar.translucent = YES;
        }
            break;
            
        case DTTabBarStyleGray: {
            //BACKGROUND
            UIImage* tabBarBackground = [UIImage imageNamed:@"Bar"];
            [self.tabBar setBackgroundImage:tabBarBackground];
            
            //TRANSLUCENT
            self.tabBar.translucent = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)setupNewMessages {
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    [item1 setImage:[[UIImage imageNamed:@"TabBarMessages"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"TabBarMessagesNew"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

- (void)HideBar:(BOOL)hidden {
    [self setTabBarHidden:hidden animated:YES];
}

@end
```

## Add TabBarController programmatically

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

- (void)transitionToTabBar {
    
    DTRootTabBarController *mainVC = [DTRootTabBarController new];
    
    DTFeedNoOneViewController *feedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DTFeedNoOneViewController"];
    DTChatListViewController *chatVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DTChatListViewController"];
    DTProfileSettingsViewController *settingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DTProfileSettingsViewController"];
    
    DTRootNavigationController *rootFeedVC = [[DTRootNavigationController alloc] initWithRootViewController:feedVC];
    DTRootNavigationController *rootChatVC = [[DTRootNavigationController alloc] initWithRootViewController:chatVC];
    DTRootNavigationController *rootSettingsVC = [[DTRootNavigationController alloc] initWithRootViewController:settingsVC];
    
    mainVC.viewControllers = @[rootFeedVC, rootChatVC, rootSettingsVC];
    
    [self presentViewController:mainVC animated:YES completion:nil];
    
    [mainVC setSelectedIndex:2];
   
    [self.window addSubview:mainVC.view];
}
```

## Combine TabBarController and NavigationController

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *firstViewController = [[UIViewController alloc] init];
    UIViewController *secondViewController = [[UIViewController alloc] init];
    UIViewController *thirdViewController = [[UIViewController alloc] init];

       UITabBarController *tabBarController = [[UITabBarController alloc] init];        
       tabBarController.viewControllers = @[firstViewController, secondViewController, thirdViewController];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}
```

## Use MainTabBarController from Storyboard with AppDelegate

```objc
//Transition to MainTabBarController
- (IBAction)okButtonTapped:(id)sender
{
    DTMainTabBarViewController *mainTabBar = [self.storyboard instantiateViewControllerWithIdentifier:@"DTMainTabBarViewController"];
    
    DTAppDelegate *appDelegate = (DTAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.window setRootViewController:mainTabBar];
}
```


