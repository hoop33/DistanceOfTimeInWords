//
//  Copyright 2011 Rob Warner
//  @hoop33
//  rwarner@grailbox.com
//  http://grailbox.com


//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "NSDate+Formatting.h"

#define SECONDS_PER_MINUTE 60.0
#define SECONDS_PER_HOUR   3600.0
#define SECONDS_PER_DAY    86400.0
#define SECONDS_PER_MONTH  2592000.0
#define SECONDS_PER_YEAR   31536000.0

@implementation NSDate (formatting)

- (NSString *)formatWithString:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

- (NSString *)formatWithStyle:(NSDateFormatterStyle)style {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    NSString *string = [formatter stringFromDate:self];
    return string;
}

- (NSString *)distanceOfTimeInWords {
    return [self distanceOfTimeInWords:[NSDate date]];
}

- (NSString *)distanceOfTimeInWords:(NSDate *)date {
    NSString *Ago               = NSLocalizedString(@"ago", @"Denotes past dates");
    NSString *FromNow           = NSLocalizedString(@"from now", @"Denotes future dates");
    NSString *LessThan          = NSLocalizedString(@"Less than", @"Indicates a less-than number");
    NSString *About             = NSLocalizedString(@"About", @"Indicates an approximate number");
    NSString *Over              = NSLocalizedString(@"Over", @"Indicates an exceeding number");
    NSString *Almost            = NSLocalizedString(@"Almost", @"Indicates an approaching number");
    //NSString *Second   = NSLocalizedString(@"second", @"One second in time");
    NSString *Seconds           = NSLocalizedString(@"seconds", @"More than one second in time");
    NSString *Minute            = NSLocalizedString(@"minute", @"One minute in time");
    NSString *MinutesSecondary  = NSLocalizedString(@"minutes secondary", @"More than one minute in time");
    NSString *Minutes           = NSLocalizedString(@"minutes", @"More than one minute in time");
    NSString *Hour              = NSLocalizedString(@"hour", @"One hour in time");
    NSString *HoursSecondary    = NSLocalizedString(@"hours secondary", @"More than one hour in time");
    NSString *Hours             = NSLocalizedString(@"hours", @"More than one hour in time");
    NSString *Day               = NSLocalizedString(@"day", @"One day in time");
    NSString *DaysSecondary     = NSLocalizedString(@"days secondary", @"More than one day in time");
    NSString *Days              = NSLocalizedString(@"days", @"More than one day in time");
    NSString *Month             = NSLocalizedString(@"month", @"One month in time");
    NSString *MonthsSecondary   = NSLocalizedString(@"months secondary", @"More than one month in time");
    NSString *Months            = NSLocalizedString(@"months", @"More than one month in time");
    NSString *Year              = NSLocalizedString(@"year", @"One year in time");
    NSString *YearsSecondary    = NSLocalizedString(@"years secondary", @"More than one year in time");
    NSString *Years             = NSLocalizedString(@"years", @"More than one year in time");
    
    NSTimeInterval since = [self timeIntervalSinceDate:date];
    NSString *direction = since <= 0.0 ? Ago : FromNow;
    since = fabs(since);
    
    int seconds   = (int)since;
    int minutes   = (int)round(since / SECONDS_PER_MINUTE);
    int hours     = (int)round(since / SECONDS_PER_HOUR);
    int days      = (int)round(since / SECONDS_PER_DAY);
    int months    = (int)round(since / SECONDS_PER_MONTH);
    int years     = (int)floor(since / SECONDS_PER_YEAR);
    int offset    = (int)round(floor((float)years / 4.0) * 1440.0);
    int remainder = (minutes - offset) % 525600;
    
    int number;
    NSString *measure;
    NSString *modifier = @"";
    
    switch (minutes) {
        case 0 ... 1:
            measure = Seconds;
            switch (seconds) {
                case 0 ... 4:
                    number = 5;
                    modifier = LessThan;
                    break;
                case 5 ... 9:
                    number = 10;
                    modifier = LessThan;
                    break;
                case 10 ... 19:
                    number = 20;
                    modifier = LessThan;
                    break;
                case 20 ... 39:
                    number = 30;
                    modifier = About;
                    break;
                case 40 ... 59:
                    number = 1;
                    measure = Minute;
                    modifier = LessThan;
                    break;
                default:
                    number = 1;
                    measure = Minute;
                    modifier = About;
                    break;
            }
            break;
        case 2 ... 44:
            switch (minutes) {
                case 2 ... 4:
                    measure = MinutesSecondary;
                    break;
                default:
                    measure = Minutes;
                    break;
            }
            number = minutes;
            break;
        case 45 ... 89:
            number = 1;
            measure = Hour;
            modifier = About;
            break;
        case 90 ... 1439:
            switch (minutes) {
                case 90 ... 239:
                    measure = HoursSecondary;
                    break;
                default:
                    measure = Hours;
                    break;
            }
            number = hours;
            modifier = About;
            break;
        case 1440 ... 2529:
            number = 1;
            measure = Day;
            break;
        case 2530 ... 43199:
            switch (minutes) {
                case 2880 ... 7199:
                    measure = DaysSecondary;
                    break;
                default:
                    measure = Days;
                    break;
            }
            
            number = days;
            break;
        case 43200 ... 86399:
            number = 1;
            measure = Month;
            modifier = About;
            break;
        case 86400 ... 525599:
            switch (minutes) {
                case 86400 ... 215999:
                    measure = MonthsSecondary;
                    break;
                default:
                    measure = Months;
                    break;
            }
            
            number = months;
            break;
        default:
            number = years;
            if (number == 1) {
                measure = Year;
            } else if (number > 1 && number < 5) {
                measure = YearsSecondary;
            } else {
                measure = Years;
            }
            
            if (remainder < 131400) {
                modifier = About;
            } else if (remainder < 394200) {
                modifier = Over;
            } else {
                ++number;
                measure = Years;
                modifier = Almost;
            }
            break;
    }
    if ([modifier length] > 0) {
        modifier = [modifier stringByAppendingString:@" "];
    }
    return [NSString stringWithFormat:@"%@%d %@ %@", modifier, number, measure, direction];
}

@end