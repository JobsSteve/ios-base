81. Gestures. Tap Gesture.
==

## Tap Gesture через IB.

1. Открываем `Show the Object Library` и выбираем компонент `Tap Gesture Recognizer`.

2. Помещаем этот компонент на любой `UI-объект (UILabel, UIButton, UIImageView, UIView)`. 

3. В `сториборд навигации` выбираем Tap Gesture и создаем `Action Outlet` - напр:. `-nextImageViewGestureTap:`

__Вот так выглядит обзор работы с Tap Gesture через IB__

![Tap Gestures](https://github.com/arthurigberdin/ios-base/blob/master/Images/Gestures/tap_gestures.png)

[Исходник проекта](https://github.com/arthurigberdin/ios-base/tree/master/Projects/IGSGestures)

## Long Press Gesture Recognizer. Устраняем повторное нажатие.

```objc
UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
[self.button addGestureRecognizer:longPress];
[longPress release];
```

```objc
- (void)longPress:(UILongPressGestureRecognizer*)gesture {

    if ( gesture.state == UIGestureRecognizerStateBegan ) {
         NSLog(@"Long Press");
    }
}
````
