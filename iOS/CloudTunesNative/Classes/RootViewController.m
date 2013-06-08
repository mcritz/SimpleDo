#import "RootViewController.h"

#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"
#import "SFMission.h"
#import "SFTask.h"
#import "MissionTableViewController.h"

@interface RootViewController()
@property (nonatomic) NSString* userId;
@end

@implementation RootViewController

//Lazy initialization of the missions
-(NSMutableArray *)allMissions
{
    if(!_allMissions)_allMissions = [[NSMutableArray alloc] init];
    return _allMissions;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
        self.userId = idData.userId;
        SFRestRequest *request;
        NSString* queryString = [NSString stringWithFormat:@"%@%@%@",
                                 @"SELECT Id,Assigned_To__c,Name,Status__c, (select id, Status,Subject,WhatId, order__c from tasks where Status not in ('Cancelled') order by order__c desc) FROM Mission__c where Status__c<>'Failed' and Assigned_To__c='", self.userId,@"'"];
        
        request = [[SFRestAPI sharedInstance] requestForQuery:queryString];
        
        [[SFRestAPI sharedInstance] send:request delegate:self];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    NSLog(@"response %@", response);
    NSArray *missions = [response objectForKey:@"records"];
    NSLog(@"missions----%@",missions);
    NSLog(@"request:didLoadResponse: #records: %d", missions.count);
    for (NSDictionary *record in missions) {
        NSLog(@"mission----%@",record);
        NSDictionary *responseTasksObject = [record objectForKey:@"Tasks"];
        NSLog(@"responseTasksObject\r %@", responseTasksObject);
        NSMutableArray *tasksArray = [[NSMutableArray alloc] init];
        
        if( ![responseTasksObject isEqual:[NSNull null]] ) {
            NSDictionary *responseTasks = [responseTasksObject objectForKey:@"records"];
            for(NSMutableDictionary *singleTask in responseTasks){
                NSLog(@"singleTask %@", singleTask);
                SFTask *task = [[SFTask alloc] initWithDictionary:singleTask];
                
                [tasksArray addObject:task];
            }
        } else {
            NSLog(@"no tasks!");
            NSDictionary *noTasksDictionary = @{@"taskStatus": @"No tasks"};
            SFTask *task = [[SFTask alloc] initWithDictionary:[noTasksDictionary mutableCopy]];
            [tasksArray addObject:task];
        }
        SFMission* thisMission = [[SFMission alloc] initWithMissionId:[record objectForKey:@"Id"] andName:[record objectForKey:@"Name"] andStatus:[record objectForKey:@"Status__c"] andTasks:tasksArray];
         NSLog(@"thismission inside---%@",thisMission);
        [self.allMissions addObject:thisMission];
         NSLog(@"allmissions inside---%@",self.allMissions);
    }
    
    [self.tableView reloadData];
}


- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    
    //here is a sample of handling errors neatly.
    NSLog(@"RootViewController:didFailWithError: %@", error);
    
    // show alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Database.com Error"
                                                    message:[NSString stringWithFormat:@"Problem retrieving data %@", error]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    //use the sample above to write your specific handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    //  use the sample above to write your specific handling here
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allMissions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    SFMission *obj = [self.allMissions objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.thisMissionName;
    
    //add the arrow to the right hand side
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




#pragma mark - Mobile SDK additional samples
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *obj = [allAlbums objectAtIndex:indexPath.row];
    NSString *aid = [obj objectForKey:@"Id"];
    NSString *objectType = @"Album__c";
    SFRestRequest *request;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete from the cloud
        request = [[SFRestAPI sharedInstance] requestForDeleteWithObjectType:objectType objectId:aid];
        
        
        SFRestRequest *request = [SFRestRequest requestWithMethod:SFRestMethodDELETE path:aid queryParams:nil];
        
        //in our sample app, once a delete is done, we are done, thus no delegate callback
        [[SFRestAPI sharedInstance] send:request delegate:nil];
        
        //delete the row from the array
        [allAlbums removeObject:obj];
        
        // Delete the row from the table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SFMission *selectedMission = [self.allMissions objectAtIndex:indexPath.row];
    NSLog(@"selected mission in didselectrow----%@",selectedMission);
    UITableViewController *missionTVC = [[MissionTableViewController alloc] initWithMission:selectedMission :@"MissionTableViewController" :nil];
    [self.navigationController pushViewController:missionTVC animated:YES];
    [missionTVC release];
}

@end
