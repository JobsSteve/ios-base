64. AppDelegate - точка входа в приложение. Foreground. Background.
==

## Foreground. Background.

```objc
//Выход в бэкграунд
- (void)applicationDidEnterBackground:(UIApplication *)application NS_AVAILABLE_IOS(4_0);
```

```objc
//Выход из фореграунда (фона)
- (void)applicationWillEnterForeground:(UIApplication *)application NS_AVAILABLE_IOS(4_0);
```

```objc
//Вход в активное состояние
- (void)applicationDidBecomeActive:(UIApplication *)application;
```


```objc
- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
    [[DTApi instance] applicationWillResignActive];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (!DTApi.instance.isInternetConnected) {
        DTLog(@"QM_STR_CHECK_INTERNET_CONNECTION");
//        [REAlertView showAlertWithMessage:NSLocalizedString(@"QM_STR_CHECK_INTERNET_CONNECTION", nil) actionSuccess:NO];
        return;
    }
    if (!DTApi.instance.currentUser) {
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[DTApi instance] applicationDidBecomeActive:^(BOOL success) {
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDTApplicationDidBecomeActive object:nil];
    }];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
```





