//
//  MissionTableViewController.m
//  SimpleDo
//
//  Created by Michael Critz on 6/5/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "MissionTableViewController.h"
#import "SFTask.h"
#import "TaskViewController.h"
#import "NewTaskViewController.h"

@interface MissionTableViewController ()
@end

@implementation MissionTableViewController

- (UITableViewController *)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.selectedMission = mission;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Tasks"];

    // custom addButton view
//    UIImage *buttonImage = [UIImage imageNamed:@"buttonAdd.png"];
//    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [aButton setImage:buttonImage forState:UIControlStateNormal];
//    [aButton setImage:[UIImage imageNamed:@"buttonAddActive.png"]  forState:UIControlStateHighlighted] ;
//    aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [aButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];

    self.navigationItem.rightBarButtonItem = self.addButton;
    
    /*
    // customBackButton view
    UIImage *backButtonImage = [UIImage imageNamed:@"buttonBack.png"];
    UIImage *backButtonImageActive = [UIImage imageNamed:@"buttonBackActive.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton setImage:backButtonImageActive forState:UIControlStateHighlighted];
    CGRect backButtonFrame = {0.0, 0.0, backButtonImage.size.width, backButtonImage.size.height};
    backButton.frame = backButtonFrame;
    UILabel *backLabel = [[UILabel alloc] initWithFrame:backButtonFrame];
    [backLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14]];
    [backLabel setBackgroundColor:[UIColor clearColor]];
    [backLabel setTextColor:[UIColor whiteColor]];
    [backLabel setTextAlignment:NSTextAlignmentCenter];
    backLabel.text = @"Missions";
    [backButton addSubview:backLabel];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = self.backButton;
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonPressed {
    NSLog(@"backButtonPressed");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addButtonPressed {
    NSLog(@"addButtonPressed");
    
    NewTaskViewController* newTaskVC =  [[NewTaskViewController alloc] initWithMission:self.selectedMission :nil :nil];
//    NSLog(@"mission ---name:\r%@,status:\r%@,id:\r%@",self.selectedMission.thisMissionName, self.selectedMission.thisMissionStatus, self.selectedMission.thisMissionId);
    [newTaskVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:newTaskVC animated:YES];
    [newTaskVC release];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // to rule them all
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // hopefully not zero…
    return [self.selectedMission.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    SFTask *obj = [self.selectedMission.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.taskSubject;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSLog(@"task: \r%@\r\rindexPath:\r%@", self.selectedMission.tasks, indexPath);
    SFTask *task = [self.selectedMission.tasks objectAtIndex:indexPath.row];
    TaskViewController *taskVC = [[TaskViewController alloc]initWithTask:task :@"TaskViewController" :nil];

    [self.navigationController pushViewController:taskVC animated:YES];
    [taskVC release];
}

@end
