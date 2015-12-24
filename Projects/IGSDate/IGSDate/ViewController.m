//
//  ViewController.m
//  IGSDate
//
//  Created by Artur on 17/12/15.
//  Copyright © 2015 Artur Igberdin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIDatePicker *beginsDatePicker;

//Begins Time
@property (weak, nonatomic) IBOutlet UITextField *beginsTextField;

//Universal Time
//@"2016-12-09T11:08:44.820Z",
@property (weak, nonatomic) IBOutlet UITextField *universalTextField;

//Human Time
@property (weak, nonatomic) IBOutlet UITextField *humanTextField;


@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBeginsDatePicker];
}

#pragma mark - Setups

- (void)setupBeginsDatePicker
{
    if (!self.beginsDatePicker)
    {
        self.beginsDatePicker = [[UIDatePicker alloc] init];
        self.beginsDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.beginsDatePicker.backgroundColor = [UIColor whiteColor];
        
        //Min - current day
        NSDate *currentDate = [NSDate date];
        self.beginsDatePicker.minimumDate = currentDate;
        
        [self.beginsTextField setInputView:self.beginsDatePicker];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *doneBtn =
        [[UIBarButtonItem alloc] initWithTitle:@"Далее"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(showBeginsDate)];
        doneBtn.tintColor = [UIColor blackColor];
        UIBarButtonItem *cancelButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Отменить"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(cancelDate)];
        cancelButton.tintColor = [UIColor redColor];
        
        UIBarButtonItem *space =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:nil
                                                      action:nil];
        
        [toolBar setItems:[NSArray arrayWithObjects:cancelButton, space, doneBtn, nil]];
        [self.beginsTextField setInputAccessoryView:toolBar];
    }
}

#pragma mark - Actions

- (void)cancelDate {
    
    [self.beginsTextField resignFirstResponder];
}

- (void)showBeginsDate {
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd MMMM yyyy HH:mm"];
    
    self.beginsTextField.text =
    [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.beginsDatePicker.date]];
    
    
    self.universalTextField.text = [self getUTCFormateDate:self.beginsDatePicker.date];
    
    self.humanTextField.text = [self relativeDate:self.beginsDatePicker.date];
    
    [self.beginsTextField resignFirstResponder];
}

//@"2016-12-09T11:08:44.820Z"
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

//Relative Format
- (NSString *) dateDifference:(NSDate *)date
{
    const NSTimeInterval secondsPerDay = 60 * 60 * 24;
    NSTimeInterval diff = [date timeIntervalSinceNow] * -1.0;
    
    // if the difference is negative, then the given date/time is in the future
    // (because we multiplied by -1.0 to make it easier to follow later)
    if (diff < 0)
        return @"In the future";
    
    diff /= secondsPerDay; // get the number of days
    
    // if the difference is less than 1, the date occurred today, etc.
    if (diff < 1)
        return @"Today";
    else if (diff < 2)
        return @"Yesterday";
    else if (diff < 8)
        return @"Last week";
    else
        return [date description]; // use a date formatter if necessary
}

//@"Завтра, 1:53 или Послезавтра, 1:53"
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




@end
