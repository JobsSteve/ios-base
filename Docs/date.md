19. NSDate. NSDateFormatter. NSLocale.
==

## [NSDate date] - Что возвращает?

Возвращает текущую дату не в UTC. (UTC таймзону нужно устанавливать отдельно в форматтер и прогонять эту дату через форматтер с павильной таймзоной).

`UTC` (Universal Coordinated Time) - всемирное координированное время.


## Интервалы времени - дни/часы/минуты/секунды

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

## UTC Форматтер для такого значения @"2016-12-09T11:08:44.820Z"

```objc
- (NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:sss'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    //[dateFormatter release];
    
    return dateString;
}
```

## Relative Date Formatter. "Завтра, 1:53 или Послезавтра, 1:53".

```objc
- (NSString *)relativeDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = kCFDateFormatterShortStyle;
    dateFormatter.dateStyle = kCFDateFormatterLongStyle;
    NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    dateFormatter.locale = ruLocale;
    
    dateFormatter.doesRelativeDateFormatting = YES;
  
    //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*3];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"dateString: %@", dateString);
    
    return dateString;
}
```

## Вопросы:

* 1.Changing language on the fly, in running iOS, iphone app?




