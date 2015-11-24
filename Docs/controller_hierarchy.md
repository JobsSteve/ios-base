21. Controller hierarchy. Navigation hierarchy.  RootController. RootNavigationController. RootTabBarController. Autorotation. StatusBar. AppDelegate.
==

##Status Bar (Lighten)
###Status bar (RootController)

**1 способ**
- Этот метод можно определить в `RootController` классе-контроллере и потом наследовать от него другие классы-контроллеры.
```objc
//In Project-Info.plist set to UIViewControllerBasedStatusBarAppearance = YES.
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
```
###Status bar (Project Plist)
**2 способ**
- Status bar можно кастомизировать, без кода.

В **project plist** помещаем:
* Status bar style: `UIStatusBarStyleLightContent`
* View controller-based status bar appearance: `NO`
* Status bar is initially hidden: `NO`

##Root Navigation Controller

###Hides back button in Navigation Bar
```objc
self.navigationItem.hidesBackButton = YES;
```
##Root TabBar Controller

###Switch between controller in TabBarController container
```objc
[self.tabBarController setSelectedIndex:0];
```

##Autorotation

##View Controller

You can use the Restoration ID:
```objc
NSString *restorationId = self.restorationIdentifier;
```
##UIApplication

```objc
if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive]) {
    //code here
}
```

### AppDelegate

```objc
#import "AppDelegate.h"

//Initialize appDelegate
self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

//Use appDelegate's property
HomeController *homeVC = (HomeController *)_appDelegate.homeController;
```

##Скрываем влияние Status Bar для Tableview

```objc
    //Скрываем влияние status bar-a для tableview
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
``` 

## PPTopMostController - получение последнего на экране контроллера

PPTopMostController - поставляется как сторонняя библиотека.

Добавление в Podfile
```
pod 'PPTopMostController'
```

Импортируется как
```objc
#import "UIViewController+PPTopMostController.h"
```

Использовать можно следующим образом:
```objc
//Сохранять в свойство (глобально)
@property (weak, nonatomic) UIViewController *topMostController;

//Сохранять локально (использовать локально в методе)
UIViewController *previousController = [UIViewController topMostController];

//Логать и следить в потоке
DTLog(@"TOP MOST CONTROLLER = %@", [UIViewController topMostController]);
```

