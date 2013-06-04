#import <UIKit/UIKit.h>
#import "SFMission.h"

@interface TaskViewController : UIViewController
- (id)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil;
@property (retain, nonatomic) IBOutlet UILabel *taskLabel;
@property (nonatomic, retain) SFMission* selectedMission;
@end
