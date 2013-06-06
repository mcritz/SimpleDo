//
//  Created by Prashanth Reddy Kambalapally on 5/31/13.
//  © 2013 Map of the Unexplored
//

#import "TaskViewController.h"
#import "SFMission.h"
#import "SFTask.h"

@interface TaskViewController ()
@property (nonatomic, retain) NSString *taskText;
@end

@implementation TaskViewController
@synthesize taskLabel;

# pragma mark - View Lifecycle

- (id)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.selectedMission = mission;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI{
    NSLog(@"tasks of the selected mission---%@",self.selectedMission.tasks);
    [self setTitle:self.selectedMission.thisMissionName];
    if(![self.selectedMission.tasks isEqual:[NSNull null]])
    {
        self.taskText = [self.selectedMission.tasks[0] taskSubject];
    } else {
        self.taskText = @"No Missions";
    }
    [self.taskLabel setText:self.taskText];
//    NSLog(@"taskText: \r%@\r taskLabel:\r%@", self.taskText, self.taskLabel);
    
}

# pragma mark - Memory Management

- (void)dealloc {
    [taskLabel release];
    [super dealloc];
}

// [self.selectedMission updateTask:[[[mission.thisMissionTasks objectForKey:@"records"] objectAtIndex:0] objectForKey:@"Id"] withStatus:@"Completed"];

@end
