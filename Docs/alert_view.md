10. Проблема с UIAlertView. UIAlertController. UIAlertController+Blocks.
==


## Проблема с UIAlertView и UIActionSheet. UIAlertController.

Проблема с UIAlertView и UIActionSheet - deprecated в iOS 9.

Теперь нужно использовать UIAlertController - кот. управляет алертами и экшеншитами (actionsheet).


UIAlertController представлен в iOS8 и поддерживает 2 стиля: alert dialog (UIAlertView) и action sheet (UIActionSheet).


typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
    UIAlertControllerStyleActionSheet = 0,
    UIAlertControllerStyleAlert
} NS_ENUM_AVAILABLE_IOS(8_0);


### Simple Alert Dialog 

```objc
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My Title"
                                                               message:@"Enter User Credentials"
                                                         preferedStyle:UIAlertControllerStyleAlert];

[self presentViewController: alert animated:YES completion:nil];
```





## UIAlertController+Blocks.

Обертка (wrapper) для UIAlertController, которая позволяет оформалять в алерты/экшеншиты (actionsheet) в одном блочном методе.

```objc
//Вызов алерта происходит вот таким образом
[UIAlertController showAlertInViewController:self
                                   withTitle:@"Test Alert"
                                     message:@"Test Message"
                           cancelButtonTitle:@"Cancel"
                      destructiveButtonTitle:@"Delete"
                           otherButtonTitles:@[@"First Other", @"Second Other"]
                                    tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){

                                if (buttonIndex == controller.cancelButtonIndex) {

                                    NSLog(@"Cancel Tapped");
                                } else if (buttonIndex == controller.destructiveButtonIndex) {

                                    NSLog(@"Delete Tapped");
                                } else if (buttonIndex >= controller.firstOtherButtonIndex) {

                                    NSLog(@"Other Button Index %ld", (long)buttonIndex - controller.firstOtherButtonIndex);
                                }
                            }];
```


```objc
//API метода для вызова экшеншита (actionsheet)
+ (instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
             popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock;
```