
Navigation Controller Appearance. Root TabBarController.
==

## Установка левой кнопки (Left Bar Button Item).

```objc
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackButtonIcon"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backToWelcomeController:)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
```





