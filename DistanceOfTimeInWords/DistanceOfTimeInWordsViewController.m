//
//  DistanceOfTimeInWordsViewController.m
//  DistanceOfTimeInWords
//
//  Created by Rob Warner on 4/12/11.
//  Copyright 2011 Grailbox. All rights reserved.
//

#import "DistanceOfTimeInWordsViewController.h"
#import "NSDate+Formatting.h"

@implementation DistanceOfTimeInWordsViewController
@synthesize datePicker;
@synthesize formattedDate;
@synthesize modeSelector;

- (void)dealloc {
  [datePicker release];
  [formattedDate release];
  [modeSelector release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Set to today's date / time and update label
  [datePicker setDate:[NSDate date] animated:NO];
  [self dateChanged];
}

- (void)viewDidUnload {
  self.datePicker = nil;
  self.formattedDate = nil;
  self.modeSelector = nil;
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dateChanged {
  NSDate *date = datePicker.date;
  formattedDate.text = [date distanceOfTimeInWords];
}

- (IBAction)dateModeChanged:(id)sender {
  switch(self.modeSelector.selectedSegmentIndex) {
    case 0:
      datePicker.datePickerMode = UIDatePickerModeTime;
      break;
    case 1:
      datePicker.datePickerMode = UIDatePickerModeDate;
      break;
    case 2:
      datePicker.datePickerMode = UIDatePickerModeDateAndTime;
      break;
  }
}

@end
