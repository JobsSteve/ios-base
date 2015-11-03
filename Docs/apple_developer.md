
40. Blocks. Как именовать блоки.
==

## Демонстрация использования блоков
```objc

typedef void (*QBChatResultBlock)(BOOL success);

//Объявление метода
- (void)loginChat:(QBChatResultBlock)block;

//Релизация метода
- (void)loginChat:(QBChatResultBlock)block {
  ...
  block (YES);
}

//Как использовать
[self loginChat:^(BOOL success) {

}];
```

```objc
//Не предпочтительная реализация блока
- (void)loginChat:(void(^)(BOOL success))block {

}
```










