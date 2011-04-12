//
//  DistanceOfTimeInWordsAppDelegate.h
//  DistanceOfTimeInWords
//
//  Created by Rob Warner on 4/12/11.
//  Copyright 2011 Grailbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DistanceOfTimeInWordsViewController;

@interface DistanceOfTimeInWordsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DistanceOfTimeInWordsViewController *viewController;

@end
