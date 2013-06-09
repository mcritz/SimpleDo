//
//  NewTaskViewController.m
//  SimpleDo
//
//  Created by Michael Critz on 6/6/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "NewTaskViewController.h"
#import "SFTask.h"

@interface NewTaskViewController ()
@property (nonatomic, retain) SFMission *selectedMission;
@property (nonatomic, retain) IBOutlet UINavigationBar *createTaskNavBar;
@end

@implementation NewTaskViewController

- (NewTaskViewController *)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.selectedMission = mission;
    }
    NSLog(@"NewtaskVC inited %@",self.selectedMission);
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *brandColor = [UIColor colorWithRed:0.18 green:0.20 blue:0.30 alpha:1];
    [self.navigationController.navigationBar setTintColor:brandColor];
    [self.createTaskNavBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    [self createTask];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createTask {
    [SFTask createTask:nil withMissionId:self.selectedMission.thisMissionId andSubject:self.taskTextview.text];
    [self dismissViewControllerAnimated:YES completion:nil];
    SFTask *newTask = [[SFTask alloc] init];
    [self.selectedMission.tasks addObject:newTask];
}

- (void)dealloc {
    [_taskTextview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTaskTextview:nil];
    [super viewDidUnload];
}
@end
