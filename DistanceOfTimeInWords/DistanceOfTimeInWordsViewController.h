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
  UISegmentedControl *modeSelector;
}
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UILabel *formattedDate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *modeSelector;

- (IBAction)dateChanged;
- (IBAction)dateModeChanged:(id)sender;

@end
