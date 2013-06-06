//
//  Created by Prashanth Reddy Kambalapally on 5/31/13.
//  © 2013 Map of the Unexplored
//

#import <UIKit/UIKit.h>
#import "SFMission.h"

@interface TaskViewController : UIViewController
- (id)initWithMission:(SFMission *)task :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil;
@property (retain, nonatomic) IBOutlet UILabel *taskLabel;
@property (nonatomic, retain) SFMission* selectedMission;
@end
