
User-Defined
==

### Хранение в плисте (Info.plist)

В Info.plist определяем как: `MAIN_URL`

```
//объявляем define
#define MAIN_URL [[[NSBundle mainBundle] infoDictionary] objectForKey:@"MAIN_URL"]

//Выводим в консоль, поскольку через po print не работает
NSLog(@"MAIN_URL = %@", MAIN_URL);
```



