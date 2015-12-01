76. Отложенный Handler (Completion Block). 
==

__.h__

```objc
//Completion Handler
typedef void (^VKSuccessHandler)(NSString *sessionToken);

@interface DTVKService : DTBaseService <VKSdkDelegate>

//Метод который будем в дальнейшем использовать
- (void)connectToVK:(NSArray *)permissions completion:(void(^)(NSString *sessionToken))completion;
```

__.m__

```objc
@interface DTVKService()

//Создаем свойство для хранения Completion Handler
@property (copy, nonatomic) VKSuccessHandler vkAuthorizeHandler;
@end

- (void)connectToVK:(NSArray *)permissions 
-        completion:(void(^)(NSString *sessionToken))completion {
-   //Здесь происходит привязка completion к выполнению блока self.vkAuthorizeHandler     
    self.vkAuthorizeHandler = completion;
    [VKSdk authorize:permissions];
}

/**
 Notifies delegate about receiving new access token
 @param newToken new token for API requests
 */
- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    if (self.vkAuthorizeHandler) {
        self.vkAuthorizeHandler(newToken.accessToken);
    }
}

/**
 Notifies delegate about user authorization cancelation
 @param authorizationError error that describes authorization error
 */
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    
    if (self.vkAuthorizeHandler) {
        self.vkAuthorizeHandler(nil);
    }
    
}
```




