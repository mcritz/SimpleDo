//
//  NewTaskViewController.h
//  SimpleDo
//
//  Created by Michael Critz on 6/6/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet UITextView *newTaskTextview;

@end
