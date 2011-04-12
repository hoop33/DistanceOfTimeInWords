//
//  DistanceOfTimeInWordsViewController.h
//  DistanceOfTimeInWords
//
//  Created by Rob Warner on 4/12/11.
//  Copyright 2011 Grailbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistanceOfTimeInWordsViewController : UIViewController {
    
  UIDatePicker *datePicker;
  UILabel *formattedDate;
}
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UILabel *formattedDate;

- (IBAction)dateChanged;

@end
