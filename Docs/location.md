63. Location. Permission. Get location on map.
==


## How to check location service is enable/disable

```objc
    if([CLLocationManager locationServicesEnabled]&&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        NSLog(@"Location service is enabled");
        
        cell.nameLabel.text = [self getFiledNameForRow:indexPath.row];
    }
    else {
        NSLog(@"Location service is disabled");
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"";
        } else {
             cell.nameLabel.text = [self getFiledNameForRow:indexPath.row];
        }
    }
	
```

## Location permissions


## AIRLocationService

###Setup Background location, CoreLocation, Background Modes.

1. Link binary with Libraries:
CoreLocation.framework

2. Capabilities > Background Modes > On
* Location updates
* Background fetch

3. KEY - NSLocationAlwaysUsageDescription > VALUE - Location is requered to use in foreground and background mode

```objc
//In `Info.plist`: KEY - NSLocationAlwaysUsageDescription > VALUE - Location is requered to use always

if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //Always authorization allows the app to receive location updates both when the app is in the foreground and in the background (suspended or terminated).
    [self.locationManager requestAlwaysAuthorization];

}
```

###Тестирование Background location in Debug Console

1. Как проверять: по шагам

Simulator>Debug>Location -> можно поставить Apple.

Потом нужно создать parking capture

Simulator>Debug>Location -> можно поставтить Freeway Drive

И уходим в Background > симуляция нажатия кнопки Home - Command+Shift+h

И в дебаг консоли смотреть distance, и если привысит 840 (тк средняя скорость для 10 минут будет 840 метров) то сообщит что road timer expired.


###Distance between locations

```objc
#import <CoreLocation/CoreLocation.h>

CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:long1];
CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat2 longitude:long2];

CLLocationDistance distance = [locA distanceFromLocation:locB];

//Distance in Meters

//1 meter == 100 centimeter
//1 meter == 3.280 feet
//1 square meter == 10.76 square feet
```




