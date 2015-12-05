10. Проблема с UIAlertView. UIAlertController. UIAlertController+Blocks.
==


## Проблема с UIAlertView и UIActionSheet. UIAlertController.

__!!! API методы UIAlertController не рекомендуется использовать из-за громоздкости и усложненной логики. Для работы с алерт-диалогами и экшеншитами идеально подходит обертка UIAlertController+Blocks.__

Проблема с __UIAlertView__ и __UIActionSheet__ - `deprecated в iOS 9`.

Теперь нужно использовать __UIAlertController__ - кот. управляет алертами и экшеншитами (actionsheet).

__UIAlertController__ `представлен в iOS8` и поддерживает 2 стиля: alert dialog (UIAlertView) и action sheet (UIActionSheet).


```objc
//Стили UIAlertController
typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
    UIAlertControllerStyleActionSheet = 0,
    UIAlertControllerStyleAlert
} NS_ENUM_AVAILABLE_IOS(8_0);
```

### Simple Alert Dialog 

```objc
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My Title"
                                                               message:@"Enter User Credentials"
                                                         preferedStyle:UIAlertControllerStyleAlert];

[self presentViewController: alert animated:YES completion:nil];
```

![Simple Alert](https://github.com/arthurigberdin/ios-base/blob/master/Images/Alerts/simple_alert.png)


### Alert Dialog with Actions

Чтобы в диалоге иметь кнопки "OK" и "Cancel" нужно создать экшен (UIAlertAction) и добавить его в UIAlertController

```objc
//Пример того как создается алерт-экшен (UIAlertActions) и добавляется в алерт-контроллер (UIAlertController)
UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                     style:UIAlertActionStyleDefault
                     handler:^(UIAlertAction * action) {
                         //Do some thing here
                         [view dismissViewControllerAnimated:YES completion:nil];
                          
                     }];
[alert addAction:ok]; // add action to uialertcontroller
```

__Полный пример алерт-контроллера с алер-экшенами (Alert Dialog) будет выглядеть таким образом__

```objc
UIAlertController * alert=   [UIAlertController
                                 alertControllerWithTitle:@"Info"
                                 message:@"You are using UIAlertController"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
   UIAlertAction* ok = [UIAlertAction
                        actionWithTitle:@"OK"
                        style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction * action) {
                            [alert dismissViewControllerAnimated:YES completion:nil];
                             
                        }];
   UIAlertAction* cancel = [UIAlertAction
                            actionWithTitle:@"Cancel"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                           }];
    
   [alert addAction:ok];
   [alert addAction:cancel];
    
   [self presentViewController:alert animated:YES completion:nil];
```

![Alert Actions](https://github.com/arthurigberdin/ios-base/blob/master/Images/Alerts/alert_actions.png)


### Action Sheet with Actions

```objc
   UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"My Title"
                                 message:@"Select you Choice"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
                                 
   UIAlertAction* ok = [UIAlertAction
                        actionWithTitle:@"OK"
                        style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction * action) {
                            //Do some thing here
                            [view dismissViewControllerAnimated:YES completion:nil];
                        }];
   UIAlertAction* cancel = [UIAlertAction
                            actionWithTitle:@"Cancel"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                [view dismissViewControllerAnimated:YES completion:nil];
                            }];
                            
   [view addAction:ok];
   [view addAction:cancel];
   [self presentViewController:view animated:YES completion:nil];
```

![Action Sheet](https://github.com/arthurigberdin/ios-base/blob/master/Images/Alerts/actionsheet_actions.png)


### Alert Dialog with Text Fields

Текстовые поля можно добавлять только в Alert Dialog-и.

```objc
[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Password"; //for passwords
    textField.secureTextEntry = YES;
}];
```

__Полный пример__

```objc
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"My Title"
                                  message:@"Enter User Credentials"
                                  preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
     
    [alert addAction:ok];
    [alert addAction:cancel];
     
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
     
    [self presentViewController:alert animated:YES completion:nil];
```

![Alert TextFields](https://github.com/arthurigberdin/ios-base/blob/master/Images/Alerts/alert_textfields.png)


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

## Подитог

В `iOS8 и iOS9` - используется __UIAlertController__ (Поэтому здесь идеальное решение [UIAlertController+Blocks](https://github.com/ryanmaxwell/UIAlertController-Blocks)).

Если нужно поддерживать `+ iOS7 и ниже` то в этом случае идеальное решение [RMUniversalAlert](https://github.com/ryanmaxwell/RMUniversalAlert).

__RMUniversalAlert__ - (обертка UIAlertView + UIActionSheet + UIAlertController).
