19. NSDate. NSDateFormatter. NSLocale.
==

### [NSDate date] - Что возвращает?

Возвращает текущую дату в UTC.

`UTC` (Universal Coordinated Time) - всемирное координированное время.


### Отобразить интервал времени - через дни/часы/минуты/секунды

```objc
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

		NSInteger interval = [self.endDate timeIntervalSinceDate:[NSDate date]];
        
    NSInteger days = (int)interval / 3600 / 24;
    NSString *daysText = [NSString stringWithFormat:@“%li", interval / 3600 / 24];

    NSString *hoursText = [NSString stringWithFormat:@“%li", (int)(interval / 3600) - (days * 24)];
    
		NSString *minutesText = ((interval % 3600) / 60) < 10 ? [NSString stringWithFormat : @“0%li", ((interval % 3600) / 60)] :[NSString stringWithFormat:@“%li", ((interval % 3600) / 60)];
		
		NSString *secondsText = interval % 60 < 10 ? [NSString stringWithFormat : @“0%li", (int)interval % 60] :[NSString stringWithFormat:@“%li", (int)interval % 60];
		
    dispatch_async(dispatch_get_main_queue(), ^{
      self.daysLabel.text = daysText;
			self.hoursLabel.text = hoursText;
			self.minutesLabel.text = minutesText;
			self.secondsLabel.text = secondsText;
		});
});
```

## Меняем локаль у форматтера (NSLocale) в зависимости от языка.

```objc
NSString *lang = [[JHUserDefaultHelper sharedInstance] getAppLanguage];
    
    if (self.locale == nil) {
        if ([lang isEqualToString:@"ru"]) {
            self.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        } else {
            self.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_EN"];
        }
    }
    //Устанавливает локаль в форматтер
    formatter.locale = self.locale;
  
    [formatter setDoesRelativeDateFormatting:YES];
    NSString *headerText = [formatter stringFromDate:firstInSection.creationDateUTC];
    
    header.label.text = headerText;
```

### Вопросы:

* 1.Changing language on the fly, in running iOS, iphone app?



