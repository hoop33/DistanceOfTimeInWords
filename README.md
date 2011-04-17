Distance of Time in Words
=========================
Rails apps use a method in `date_helper.rb` called `distance_from_time_in_words` that tells approximately how long ago something happened, e.g., "10 seconds ago" or "Almost 3 hours ago." This app duplicates this functionality in Objective-C (appropriately, it does so approximately). The magic of it all is found in a category, `NSDate+Formatting`, that you can use in your own applications. In fact, the app exists only to demonstrate how to use the category.

About the App
-------------
Open the project in Xcode and run it. You can also run its unit tests (Cmd+U) which run a series of tests against the four methods in the `NSDate+Formatting` category (see below for more info on the methods). To use the app, spin the date picker backward and forward to see the "distance of time in words" between now and the selected time. You can also change the mode of the date picker control to Time, Date, and Date & Time by clicking on the appropriate segment.

How to Use NSDate+Formatting
----------------------------
To use `NSDate+Formatting` in your application, copy `NSDate+Formatting.h` and `NSDate+Formatting.m` into your project. These four methods then become available for all of your `NSDate` instances:

* `- (NSString *)formatWithString:(NSString *)format;`
* `- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;`
* `- (NSString *)distanceOfTimeInWords;`
* `- (NSString *)distanceOfTimeInWords:(NSDate *)date;`

The first two (the ones that start with `format`) make date formatting cleaner in your code. Instead of explicitly creating, using, and release date formatters in your code, you can just call these methods directly on your date objects, passing the format string or style that you would have passed to your formatter. Examples:

* `[[NSDate date] formatWithString:@"MM-dd-yyyy"]`
* `[[NSDate date] formatWithStyle:NSDateFormatterFullStyle]`

The next two relate to each other. Calling `distanceOfTimeInWords` with no parameters returns the distance between the source date and now. Passing a date to `distanceOfTimeInWords` returns the distance between the source date and the passed date. Examples:

* `[[NSDate date] distanceOfTimeInWords]`
* `[[NSDate date] distanceOfTimeInWords:[[NSDate date] dateByAddingTimeInterval:86400]]`

Localization
------------
`NSDate+Formatting` uses localized strings, so if you localize your app and provide strings for all that `NSDate+Formatting` uses, your returned string will be localized. The app provides both english and Spanish localizations.
