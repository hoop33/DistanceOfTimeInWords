//
//  NSDate+Formatting.h
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

#import "DistanceOfTimeInWordsTests.h"
#import "NSDate+Formatting.h"

@implementation DistanceOfTimeInWordsTests

- (void)testStringFormat {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy hh:mm:ss"];
  NSDate *date = [formatter dateFromString:@"01-01-2009 06:15:15"];
  
  NSString *string = nil;
  
  string = [date formatWithString:@"MM-dd-yyyy"];
  STAssertTrue([string isEqualToString:@"01-01-2009"], @"Formatted date should be '01-01-2009,' but instead was '%@'", string);
  
  string = [date formatWithString:@"MM-dd-yyyy hh:mm:ss"];
  STAssertTrue([string isEqualToString:@"01-01-2009 06:15:15"], @"Formatted date should be '01-01-2009 06:15:15,' but instead was '%@'", string);
  
  [formatter release];
}

- (void)testStyleFormat {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy hh:mm:ss"];
  NSDate *date = [formatter dateFromString:@"01-01-2009 06:15:15"];
  
  NSString *string = nil;
  
  string = [date formatWithStyle:NSDateFormatterShortStyle];
  STAssertTrue([string isEqualToString:@"1/1/09"], @"Formatted date should be '1/1/09,' but instead was '%@'", string);
  
  string = [date formatWithStyle:NSDateFormatterLongStyle];
  STAssertTrue([string isEqualToString:@"January 1, 2009"], @"Formatted date should be 'January 1, 2009,' but instead was '%@'", string);
  
  [formatter release];
}

- (void)testDistanceOfTimeInWords {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM-dd-yyyy hh:mm:ss"];
  NSDate *date1 = [formatter dateFromString:@"01-01-2009 06:00:00"];
  
  NSDate *date2 = nil;
  NSString *string = nil;
  NSString *should = nil;
  
  date2 = [formatter dateFromString:@"01-01-2009 06:00:00"]; // 0 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Less than 5 seconds ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Less than 5 seconds ago"; // 0 is always "ago"
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:00:01"]; // 1 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Less than 5 seconds ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Less than 5 seconds from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:00:05"]; // 5 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Less than 10 seconds ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Less than 10 seconds from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:00:32"]; // 32 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 30 seconds ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 30 seconds from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:00:45"]; // 45 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Less than 1 minute ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Less than 1 minute from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:01:00"]; // 1 minute
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 minute ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 minute from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:01:15"]; // 1 minute 15 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 minute ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 minute from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:02:43"]; // 2 minutes 43 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"3 minutes ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"3 minutes from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:28:12"]; // 28 minutes 12 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"28 minutes ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"28 minutes from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 06:45:00"]; // 45 minutes
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 hour ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 hour from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2009 07:29:00"]; // 1 hour 29 minutes
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 hour ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 hour from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-02-2009 05:00:00"]; // 23 hours
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 23 hours ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 23 hours from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-02-2009 06:00:00"]; // 24 hours
  string = [date1 distanceOfTimeInWords:date2];
  should = @"1 day ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"1 day from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-04-2009 06:48:00"]; // 72 hours 48 minutes
  string = [date1 distanceOfTimeInWords:date2];
  should = @"3 days ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"3 days from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"02-01-2009 06:00:00"]; // 1 month
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 month ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 month from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"02-16-2009 06:00:00"]; // 1.5 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 month ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 month from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"03-31-2009 06:00:00"]; // 3 months minus a day
  string = [date1 distanceOfTimeInWords:date2];
  should = @"3 months ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"3 months from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"12-01-2009 06:00:00"]; // 11 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"11 months ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"11 months from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2010 06:00:00"]; // 1 year
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 1 year ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 1 year from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"01-01-2012 06:00:00"]; // 3 years
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 3 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 3 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"04-01-2012 06:00:00"]; // 3 years and 3 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 3 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 3 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"07-01-2012 06:00:00"]; // 3 years and 6 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Over 3 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Over 3 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"10-01-2012 06:00:00"]; // 3 years and 9 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Almost 4 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Almost 4 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"11-01-2012 06:00:00"]; // 3 years and 10 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Almost 4 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Almost 4 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"03-01-2013 06:00:00"]; // 4 years and 2 months
  string = [date1 distanceOfTimeInWords:date2];
  should = @"About 4 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"About 4 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  date2 = [formatter dateFromString:@"05-10-2029 10:18:42"]; // 20 years, 4 months, 9 days, 4 hours, 18 minutes, and 42 seconds
  string = [date1 distanceOfTimeInWords:date2];
  should = @"Over 20 years ago";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  string = [date2 distanceOfTimeInWords:date1];
  should = @"Over 20 years from now";
  STAssertTrue([string isEqualToString:should], @"Time ago should be '%@' but instead was '%@'", should, string);
  
  [formatter release];
}

@end
