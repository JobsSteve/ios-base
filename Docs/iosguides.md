0. iOS Guides. Codestyle guides.
=== 

## Типизированные константы VS. препроцессорные директивы #define.

```objc
//Define constant - WRONG!!!
#define ANIMATION_DURATION 0.3
```

```objc
//Typed constant - CORRECT
#static const NSTimerInterval kAnimationDuration = 0.3;
```

## Префиксы. Соглашение.

``` Префикс - k ``` - для локальных констант (констант локальных по отношению к файлу реализации).
``` kAnimationDuration ```

``` Префикс - Имя класса ``` - для глобальных констант (для констант доступных за пределами класса).
``` EOCLoginManagerDidLoginNotification ``` имя класса к которому относится константа.

``` Статические переменные ``` объявляются директивой ``` static ```. Они инициализируются только один раз - при первом вызове функции и сохраняют свое значение даже после выхода из функции. В следующий раз при новом вызове функции статические переменные будут иметь то же значение, которое они имели перед выходом из функции в послений раз.






