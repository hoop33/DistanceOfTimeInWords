//
//  NSDate+Formatting.m
//  Privately
//
//  Created by Rob Warner on 4/7/11.
//  Copyright 2011 Grailbox. All rights reserved.
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
  [formatter release];
  return string;
}

- (NSString *)formatWithStyle:(NSDateFormatterStyle)style {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:style];
  NSString *string = [formatter stringFromDate:self];
  [formatter release];
  return string;
}

- (NSString *)distanceOfTimeInWords {
  return [self distanceOfTimeInWords:[NSDate date]];
}

- (NSString *)distanceOfTimeInWords:(NSDate *)date {
  NSTimeInterval since = [self timeIntervalSinceDate:date];
  NSString *direction = since <= 0.0 ? @"ago" : @"from now";
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
      measure = @"second";
      switch (seconds) {
        case 0 ... 4:
          number = 5;
          modifier = @"Less than";
          break;
        case 5 ... 9:
          number = 10;
          modifier = @"Less than";
          break;
        case 10 ... 19:
          number = 20;
          modifier = @"Less than";
          break;
        case 20 ... 39:
          number = 30;
          modifier = @"About";
          break;
        case 40 ... 59:
          number = 1;
          measure = @"minute";
          modifier = @"Less than";
          break;
        default:
          number = 1;
          measure = @"minute";
          modifier = @"About";
          break;
      }
      break;
    case 2 ... 44:
      number = minutes;
      measure = @"minute";
      break;
    case 45 ... 89:
      number = 1;
      measure = @"hour";
      modifier = @"About";
      break;
    case 90 ... 1439:
      number = hours;
      measure = @"hour";
      modifier = @"About";
      break;
    case 1440 ... 2529:
      number = 1;
      measure = @"day";
      break;
    case 2530 ... 43199:
      number = days;
      measure = @"day";
      break;
    case 43200 ... 86399:
      number = 1;
      measure = @"month";
      modifier = @"About";
      break;
    case 86400 ... 525599:
      number = months;
      measure = @"month";
      break;
    default:
      number = years;
      measure = @"year";
      if (remainder < 131400) {
        modifier = @"About";
      } else if (remainder < 394200) {
        modifier = @"Over";
      } else {
        ++number;
        modifier = @"Almost";
      }
      break;
  }
  if (number != 1) {
    measure = [measure stringByAppendingString:@"s"];
  }
  if ([modifier length] > 0) {
    modifier = [modifier stringByAppendingString:@" "];
  }
  return [NSString stringWithFormat:@"%@%d %@ %@", modifier, number, measure, direction];
}

@end
