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
@property (nonatomic, retain) SFMission *selectedMission;
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

    // custom button view
    UIImage *buttonImage = [UIImage imageNamed:@"buttonAdd.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    [aButton setImage:[UIImage imageNamed:@"buttonAddActive.png"]  forState:UIControlStateHighlighted] ;
    aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [aButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];

    self.navigationItem.rightBarButtonItem = self.addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButtonPressed {
    NSLog(@"addButtonPressed");
    
    NewTaskViewController* newTaskVC =  [[NewTaskViewController alloc] initWithMissionId:self.selectedMission.thisMissionId :nil:nil];
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
