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

- (TaskViewController *)initWithTask:(SFTask *)task :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.task = task;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI{
    NSLog(@"tasks of the selected mission---%@", self.task);
    [self setTitle:[self.task taskSubject]];

    NSString *status;
    if(![self.task isEqual:[NSNull null]])
    {
        self.taskText = [self.task taskSubject];
        status = [self.task taskStatus];
    } else {
        self.taskText = @"No Task";
        status = @"No task present. Congratulations.";
    }
    [self.taskLabel setText:self.taskText];
    [self.taskDescription setText:status];
}

# pragma mark - Memory Management

- (void)dealloc {
    [taskLabel release];
    [_taskDescription release];
    [_completeButton release];
    [super dealloc];
}

// [self.selectedMission updateTask:[[[mission.thisMissionTasks objectForKey:@"records"] objectAtIndex:0] objectForKey:@"Id"] withStatus:@"Completed"];

- (void)viewDidUnload {
    [self setTaskDescription:nil];
    [self setCompleteButton:nil];
    [super viewDidUnload];
}
- (IBAction)completeButtonPressed:(UIButton *)sender {
    [self completeTask];
}

- (void)completeTask {
    NSLog(@"Task Complete");
    [self.task updateTask:@"Completed":self];
}

- (void)didUpdateTask:(NSString *)status {
    NSLog(@"didUpdateTask %@", status);
    [self.taskDescription setText:status];
    [self.completeButton removeFromSuperview];
}

@end
