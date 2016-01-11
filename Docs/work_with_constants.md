91. Работа с константами
==

## Правильная работа с константами

1. Добавить .pch файл

2. Добавить иерархию файлов (`Macros, Settings, Segues, Callbacks, NotificationKeys`) для констант.

### IGS-Prefix.pch

Идея иерархии - IGSDefinitions включает (Constants, NotificationKeys, Callbacks, Settings)

```objc
//Constants
#import “IGSMacros.h"
    
#import “IGSDefinitions.h"
#import “IGSNotificationKeys.h”
#import “IGSCallbacks.h”
#import “IGSSettings.h”
#import “IGSSegues.h”
```

## IGSMarcos.h
Внутри макросов сделать разделение на pragma-marks.

```objc
#pragma mark - Device Types

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
```

```objc
#pragma mark - Screen Sizes 

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
```

```objc
#pragma mark - Screen Scale
 
#define IS_RETINA               ([UIScreen mainScreen].scale >= 2)
#define IS_EXTRA_RETINA         ([UIScreen mainScreen].scale == 3)
```

```objc
#pragma mark - IOS Version

#define SYSTEM_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS7                    (7.0 <= SYSTEM_VERSION && SYSTEM_VERSION < 8.0)
#define IOS8                    (8.0 <= SYSTEM_VERSION && SYSTEM_VERSION < 9.0)
#define IOS7_OR_HIGHER          (7.0 <= SYSTEM_VERSION)
#define IOS8_OR_HIGHER          (8.0 <= SYSTEM_VERSION)
#define IOS9                    (9.0 <= SYSTEM_VERSION && SYSTEM_VERSION < 10.0)
```

```objc
#pragma mark - Device Orientation

#define IS_PORTRAIT     UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])
```

```objc
#pragma mark - Debug Log

#ifdef DEBUG
#define DLog(...) do { NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]); } while(0)
#else
#define DLog(...) do { } while (0)
#endif
```

```objc
#define DECL_CONST(_VALUE) FOUNDATION_EXTERN  NSString *const _VALUE;
#define IMPL_CONST(_VALUE) NSString *const _VALUE = @#_VALUE;
#define IMPL_CONST_TEXT(_VALUE,_TEXT) NSString *const _VALUE = _TEXT;
```

```objc
//RGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
```

```objc
//Block Safe
//Не стоит это использовать, поскольку если падает приложение - найти ошибку во вложенных блоках проще
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil

#endif
```

### IGSDefenitions.h

__Константы__

AppID, AppSecret, AppKey, AccountKey, UserPassword, Строковые константы (но для них лучше - Localyzation.strings), Енумераторы, 

```objc
#pragma mark - Constants

static const NSUInteger kDTApplicationID = 27111;
static NSString *const  kDTAuthorizationKey = @"Jf8FQXKzH-12345”;
static NSString *const  kDTUserPassword = @"c99f4462-1111-2222-3333-1697f925ec7b";

#pragma mark - Enumerators

typedef NS_ENUM(NSInteger, DTGenderControlTag)
{
    DTGenderControlTagMy = 1,
    DTGenderControlTagSearch = 2,
};
```

__Комментирование__

```objc
#pragma mark - Constants
//DTSocialNetworksService
static NSString *const kDTVKAppId = @"5047045";

//DTBlockedViewController
NSUInteger static const kDTAbuseCount = 3;
```

__Отделение PRODUCTION от DEBUG__

```objc
#ifdef PRODUCTION
	static NSString *const  kDTAuthorizationKey = @"Jf8FQXKzH-12345”;
#else
	static NSString *const  kDTAuthorizationKey = @"Jf8FQXKzH-98765”;
#endif
```

![PRODUCTION Macros](https://github.com/arthurigberdin/ios-base/blob/master/Images/production_macros.png)

## IGSNotificationKeys.h

```objc
#pragma mark - Notification Identifiers

static NSString *const kDTApplicationDidBecomeActive = @"DTApplicationDidBecomeActive";
static NSString *const kHideKeyboardNotification = @"HideKeyboardNotification";
static NSString *const kRemoveUserFromChatNotification = @"RemoveUserFromChatNotification";
static NSString *const kDislikeAndPlayNextVideoNotification = @"DislikeAndPlayNextVideoNotification";
static NSString *const kPreferencesChangedNotification = @"PreferencesChangedNotification";
static NSString *const kVideoRecordActiveNotification = @"VideoRecordActiveNotification";
```

## IGSCallbacks.h

```objc
typedef void (^IGSContentProgressBlock)(float progress);
typedef void (^IGSFileUploadTaskResultBlock)(QBCFileUploadTaskResult *result);
typedef void (^IGSFileDownloadTaskResultBlock)(QBCFileDownloadTaskResult *result);

typedef void (^QBUUserResultBlock)(QBUUserResult *result);
typedef void (^IGSUUserResultBlock)(QBResponse *response, QBUUser *user);

typedef void (^QBAAuthResultBlock)(QBAAuthResult *result);

typedef void (^QBUUserLogInResultBlock)(QBUUserLogInResult *result);
typedef void (^IGSUUserLogInResultBlock)(QBResponse *response, QBUUser *user);

typedef void (^QBAAuthSessionCreationResultBlock)(QBAAuthSessionCreationResult *result);
typedef void (^QBUUserPagedResultBlock)(QBUUserPagedResult *pagedResult);
typedef void (^QBMRegisterSubscriptionTaskResultBlock)(QBMRegisterSubscriptionTaskResult *result);
typedef void (^QBMUnregisterSubscriptionTaskResultBlock)(QBMUnregisterSubscriptionTaskResult *result);
typedef void (^QBDialogsPagedResultBlock)(QBDialogsPagedResult *result);
typedef void (^IGSDialogsPagedResultBlock)(QBResponse *response, NSArray *dialogObjects, NSSet *dialogsUsersIDs, QBResponsePage *page);

typedef void (^QBChatDialogResultBlock)(QBChatDialogResult *result);
typedef void (^QBChatHistoryMessageResultBlock)(QBChatHistoryMessageResult *result);

typedef void (^QBResultBlock)(QBResult *result);
typedef void (^QBSessionCreationBlock)(BOOL success, NSString *error);
typedef void (^QBChatResultBlock)(BOOL success);
typedef void (^QBChatRoomResultBlock)(QBChatRoom *chatRoom, NSError *error);
typedef void (^QBChatDialogHistoryBlock)(NSMutableArray *chatDialogHistoryArray, NSError *error);
```

## IGSSettings.h

```objc
#pragma mark - Settings

#define boolPref(key) ([[NSUserDefaults standardUserDefaults] boolForKey:key])
#define pref(key) ([[NSUserDefaults standardUserDefaults] valueForKey:key])

static NSString *const kPrefLikeCount = @“igs.likes";
static NSString *const kPrefMsgSent = @"igs.msgDidSent";
static NSString *const kPrefIsSecondLaunch = @"igssecondLaunch";
static NSString *const kPrefSettings = @"igs.settings";
static NSString *const kPrefAbuseCount = @"igs.abuses";
static NSString *const kPrefSocialType = @"igs.socialKind";
static NSString *const kPrefAgeRangeMinValue = @"igs.age.min";
static NSString *const kPrefAgeRangeMaxValue = @"igs.age.max";
static NSString *const kPrefLastCountdownTime = @"igs.countdown.lastTime";
static NSString *const kPrefCustomSearchLocation = @"igs.customsearchlocation";

#endif
```

## IGSSegues.h

```objc
#pragma mark - Segue identifiers

static NSString *const kIGSSplashToTourSegue = @"SplashToTourSegue";
static NSString *const kIGSplashToWelcomeSegue = @"SplashToWelcomeSegue";
static NSString *const kIGSplashToTabBarSegue = @"SplashToTabBarSegue";

static NSString *const kIGSTourToWelcomeSegue = @"TourToWelcomeSegue";
static NSString *const kIGSWelcomeToVideoPresentationTipSegue = @"WelcomeToVideoPresentationTipSegue";
static NSString *const kIGSWelcomeToFeedTipSegue = @"WelcomeToFeedTipSegue";
static NSString *const kIGSWelcomeToTabBarSegue = @"WelcomeToTabBarSegue";

static NSString *const kIGSFeedTipToTabBarSegue = @"FeedTipToTabBarSegue";
static NSString *const kIGSVideoPresentationTipToVideoPresentationSegue = @"VideoPresentationTipToVideoPresentationSegue";

//static NSString *const kDT         = @"";
```

