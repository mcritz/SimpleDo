//
//  NewTaskViewController.h
//  SimpleDo
//
//  Created by Michael Critz on 6/6/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestRequest.h"
#import "SFMission.h"

@interface NewTaskViewController : UIViewController <SFRestDelegate>
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UITextView *taskTextview;
- (NewTaskViewController *)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil;
- (void)updateUI;
@end
