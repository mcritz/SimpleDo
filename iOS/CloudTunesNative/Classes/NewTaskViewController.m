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
@property (nonatomic, retain) NSString *selectedMissionId;
@end

@implementation NewTaskViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/
- (NewTaskViewController *)initWithMissionId:(NSString *)missionId :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.selectedMissionId = missionId;
    }
    NSLog(@"NewtaskVC inited %@",self.selectedMissionId);
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [SFTask createTask:nil withMissionId:self.selectedMissionId andSubject:self.taskTextview.text];
    [self dismissViewControllerAnimated:YES completion:nil];
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
