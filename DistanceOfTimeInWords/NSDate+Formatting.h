//
//  NSDate+Formatting.h
//  Privately
//
//  Created by Rob Warner on 4/7/11.
//  Copyright 2011 Grailbox. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (formatting)

- (NSString *)formatWithString:(NSString *)format;
- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;
- (NSString *)distanceOfTimeInWords;
- (NSString *)distanceOfTimeInWords:(NSDate *)date;

@end
