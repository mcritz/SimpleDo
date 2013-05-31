//
//  TaskViewController.m
//  CloudTunesNative
//
//  Created by Prashanth Reddy Kambalapally on 5/31/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "TaskViewController.h"
#import "SFMission.h"

@interface TaskViewController ()
@property (strong, nonatomic) IBOutlet UITextView *tasksDisplay;
@end

@implementation TaskViewController


- (id)initWithMission:(SFMission *)mission
{
    self.selectedMission = mission;
    NSLog(@"tasks of the selected mission---%@",self.selectedMission.thisMissionTasks);
    self.tasksDisplay.text = [[self.selectedMission.thisMissionTasks allValues] componentsJoinedByString:@"--"];
    [self.selectedMission updateTask:[[[mission.thisMissionTasks objectForKey:@"records"] objectAtIndex:0] objectForKey:@"Id"] withStatus:@"Completed"];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
