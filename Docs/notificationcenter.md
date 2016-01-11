77. NSNotificationCenter
==

## Работа с NSNotificationCenter

```objc
//Эту константу лучше всего хранить в какой нибудь NotificationKeys.h
static NSString *const kAnimateWelcomeTour = @“IGSAnimateWelcomeTour”;
```

```objc
//Отправка
BOOL isAuthorized = [[PPAuthorizationManager sharedInstance] isAuthorized];
    if (!isAuthorized) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kAnimateWelcomeTour object:nil];
    }
```

```objc
//Прием
[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(animateWelcomeTour)
                                                 name:kAnimateWelcomeTour
                                               object:nil];
```

```objc
//Экшн
- (void)animateWelcomeTour
{
    self.arrowsImageView.hidden = NO;
    
    CGRect frameUp = self.arrowsImageView.frame;
    frameUp.origin.y -= 20;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         self.arrowsImageView.frame = frameUp;
                     }
                     completion:NULL
     ];
}
```

## Кейс для NSNotificationCenter (Refresh UI)

При выходе из неактивного состояния в активное: Перестает работать анимация элемента на экране.

```objc
- applicationWillTerminate:(UIApplication *)application
{
    BOOL isAuthorized = [[PPAuthorizationManager sharedInstance] isAuthorized];
        if (!isAuthorized) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kAnimateWelcomeTour object:nil];
        }
}
```




