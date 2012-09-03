Distance of Time in Words
=========================
Rails apps use a method in `date_helper.rb` called `distance_from_time_in_words` that tells approximately how long ago something happened, e.g., "10 seconds ago" or "Almost 3 hours ago." This app duplicates this functionality in Objective-C (appropriately, it does so approximately). The magic of it all is found in a category, `NSDate+Formatting`, that you can use in your own applications. In fact, the app exists only to demonstrate how to use the category.

License
-------
Copyright 2011 Rob Warner
@hoop33
rwarner@grailbox.com
http://grailbox.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

About the App
-------------
Open the project in Xcode and run it. You can also run its unit tests (Cmd+U) which run a series of tests against the four methods in the `NSDate+Formatting` category (see below for more info on the methods). To use the app, spin the date picker backward and forward to see the "distance of time in words" between now and the selected time. You can change the mode of the date picker control to Time, Date, and Date & Time by clicking on the appropriate segment. You can reset the date to now by clicking the "Reset date to now" button.

How to Use NSDate+Formatting
----------------------------
To use `NSDate+Formatting` in your application, copy `NSDate+Formatting.h` and `NSDate+Formatting.m` into your project. These four methods then become available for all of your `NSDate` instances:

* `- (NSString *)formatWithString:(NSString *)format;`
* `- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;`
* `- (NSString *)distanceOfTimeInWords;`
* `- (NSString *)distanceOfTimeInWords:(NSDate *)date;`

The first two (the ones that start with `format`) make date formatting cleaner in your code. Instead of explicitly creating, using, and release date formatters in your code, you can just call these methods directly on your date objects, passing the format string or style that you would have passed to your formatter. Examples:

* `[[NSDate date] formatWithString:@"MM-dd-yyyy"];`
* `[[NSDate date] formatWithStyle:NSDateFormatterFullStyle];`

The next two relate to each other. Calling `distanceOfTimeInWords` with no parameters returns the distance between the source date and now. Passing a date to `distanceOfTimeInWords` returns the distance between the source date and the passed date. Examples:

* `[[NSDate date] distanceOfTimeInWords];`
* `[[NSDate date] distanceOfTimeInWords:[[NSDate date] dateByAddingTimeInterval:86400]];`

Formatting date strings
----------------------------
These two methods are now available for formatting resulting date strings:

* `- (NSString *)distanceOfTimeInWordsWithOptions:(NSUInteger)options;`
* `- (NSString *)distanceOfTimeInWords:(NSDate *)date withOptions:(NSUInteger)options;`

Both presented methods are accepting a bitmask formed with the following options:

- kDOTIWStringComponentModifier;
- kDOTIWStringComponentNumber;
- kDOTIWStringComponentMeasure;
- kDOTIWStringComponentDirection;
- kDOTIWStringComponentJustNow; `Disabled by default.`

For instance:

	[[NSDate date] distanceOfTimeInWords]; 
	
Results "`Less than 5 seconds ago`".
	
	NSUInteger dotiwOptions = kDOTIWStringComponentNumber | kDOTIWStringComponentMeasure;
	
	[[NSDate date] distanceOfTimeInWordsWithOptions:dotiwOptions]
	
Results "`5 seconds`".
	
	dotiwOptions = kDOTIWStringComponentNumber | kDOTIWStringComponentMeasure | kDOTIWStringComponentJustNow;
	
	[[NSDate date] distanceOfTimeInWordsWithOptions:dotiwOptions]
	
    [[NSDate dateWithTimeInterval:10.0 sinceDate:oldDate] distanceOfTimeInWords:oldDate withOptions:options];
    
Results "`Just now`" for the first call and "`10 seconds` for the second call (i.e., the `kDOTIWStringComponentJustNow` component overrides others while the time interval between the defined dates (e.g. the received date and now) is smaller than 5 (five) seconds).

Localization
------------
`NSDate+Formatting` uses localized strings, so if you localize your app and provide strings for all that `NSDate+Formatting` uses, your returned string will be localized. The app provides English, Spanish, Chinese and Portuguese localizations.
