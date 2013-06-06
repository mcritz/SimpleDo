//
//  Created by Prashanth Reddy Kambalapally on 5/31/13.
//  © 2013 Map of the Unexplored
//

#import <UIKit/UIKit.h>
#import "SFTask.h"

@interface TaskViewController : UIViewController
- (TaskViewController *)initWithTask:(SFTask *)task :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil;
@property (retain, nonatomic) IBOutlet UILabel *taskLabel;
@property (retain, nonatomic) IBOutlet UITextView *taskDescription;
- (IBAction)completeButtonPressed:(UIButton *)sender;
- (void)didUpdateTask:(NSString *)status;
@property (retain, nonatomic) IBOutlet UIButton *completeButton;
@property (nonatomic, retain) SFTask* task;

@end
