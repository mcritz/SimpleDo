//
//  MissionTableViewController.m
//  SimpleDo
//
//  Created by Michael Critz on 6/5/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "MissionTableViewController.h"

#import "MissionDataRequest.h"
#import "SFTask.h"
#import "TaskViewController.h"
#import "NewTaskViewController.h"

@interface MissionTableViewController ()

@property (nonatomic)MissionDataRequest *missionData;

@end

@implementation MissionTableViewController

- (UITableViewController *)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.selectedMission = mission;
    return self;
}

- (void)updateUI {
    for (SFMission *mission in self.missionData.allMissions) {
        if (mission.thisMissionId == self.selectedMission.thisMissionId) {
            self.selectedMission = mission;
            [self.tableView reloadData];
            break;
        }
    }

    [self.missionData release];
}

- (void)viewWillAppear:(BOOL)animated {
    self.missionData = [[MissionDataRequest alloc] initWithObject:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Tasks"];
    UIColor *brandColor = [UIColor colorWithRed:0.18 green:0.20 blue:0.30 alpha:1];
    [self.navigationController.navigationBar setTintColor:brandColor];
    [self.tableView setSeparatorColor:[UIColor clearColor]];

    // custom addButton view
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];

    self.navigationItem.rightBarButtonItem = self.addButton;
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
    return [self.selectedMission.tasks count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UI
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:18]];
    SFTask *obj = [self.selectedMission.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.taskSubject;
    if ([obj.taskStatus isEqualToString:@"Completed"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.50 alpha:1]];
        [cell setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:1.00 alpha:1]];
        NSDictionary *fancyLabelAttributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger: 0 | 1]};
        NSAttributedString *fancyTaskLabel = [[NSAttributedString alloc] initWithString:obj.taskSubject
                                                                             attributes:fancyLabelAttributes];
        [cell.textLabel setAttributedText:fancyTaskLabel];
    } else {
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.49 green:0.39 blue:0.35 alpha:1]];
//        [cell setBackgroundColor:[UIColor colorWithRed:1.00 green:0.96 blue:0.90 alpha:1]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
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
