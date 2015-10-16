63. AppDelegate - точка входа в приложение
==

## How to check location service for enable/disable

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



