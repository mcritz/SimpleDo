
/*
 Copyright (c) 2011, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "RootViewController.h"

#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "TrackDetailsViewController.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"
#import "SFMission.h"
#import "TaskViewController.h"

@interface RootViewController()
@property (nonatomic) NSString* userId;
@end

@implementation RootViewController

//@synthesize allMissions;
@synthesize allAlbums;
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
        
        //Here we use a query that should work on either Force.com or Database.com
        /*SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Name FROM User LIMIT 10"];
         [[SFRestAPI sharedInstance] send:request delegate:self];
         */
        SFRestRequest *request;
        NSString* queryString = [NSString stringWithFormat:@"%@%@%@",
                                 @"SELECT Assigned_To__c,Name,Status__c, (select id, Status,Subject,WhatId, order__c from tasks) FROM Mission__c where Assigned_To__c='", self.userId,@"'"];
        
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    NSArray *missions = [response objectForKey:@"records"];
    NSLog(@"missions----%@",missions);
    NSLog(@"request:didLoadResponse: #records: %d", missions.count);
    
    //self.allMissions = [response objectForKey:@"records"];
    /*
     NSMutableArray *allDetails = [response objectForKey:@"records"];
     
     //database.com returns additional information such as attributes and number of results
     //we want the actual response...
     NSDictionary *results = [allDetails objectAtIndex:0];
     NSDictionary *allTracks =[results objectForKey:@"Tracks__r"];
     
     //payload is returned as JSON. If the value of a textfield is null, Objective-C will represent this as a NSNull object.
     //Printing it to the console will show as "<null>".
     //This is different from nil,so let's check for NSNull
     
     theAlbumDescription = [results objectForKey:@"Description__c"];
     */
    //NSMutableArray *results = [missions objectForKey:@"Tasks"];
    //  NSLog(@"results----%@",results);
    //NSMutableDictionary *allTasks = [[NSMutableDictionary alloc] init];// = [results objectForKey:@"records"];
    //NSMutableArray* allMissions = [[NSMutableArray alloc] init];
    
    for (int i=0;i<missions.count;i++) {
        NSDictionary* mission = [missions objectAtIndex:i];
        NSLog(@"mission----%@",mission);
        NSMutableDictionary* tasks = [mission objectForKey:@"Tasks"]?[mission objectForKey:@"Tasks"]:nil;
        //NSLog(@"name----%@-----status---%@",[mission objectForKey:@"Name"],[mission objectForKey:@"Status__c"] );
        
        SFMission* thisMission = [[SFMission alloc] initWithMissionId:[mission objectForKey:@"Id"] andName:[mission objectForKey:@"Name"] andStatus:[mission objectForKey:@"Status__c"] andTasks:tasks];
         NSLog(@"thismission inside---%@",thisMission);
        [self.allMissions addObject:thisMission];
         NSLog(@"allmissions inside---%@",self.allMissions);
        //[allTasks ];
    }
    
    
    NSLog(@"allmissions----%@",self.allMissions);
    
    //self.allMissions = [response objectForKey:@"records"];
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
    cell.textLabel.text =  obj.thisMissionName;//[obj objectForKey:@"Name"];
    //NSLog(@"obj.thisMissionName---%@",obj.thisMissionName );
    //UIImage *image = [UIImage imageNamed:@"tracks.png"];
    //cell.imageView.image = image;
    
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




//TODO: uncomment for delete sample
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


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate


//TODO: uncomment for subview example

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *selectedMission = [self.allMissions objectAtIndex:indexPath.row];
    NSLog(@"obj----%@",selectedMission);
    TaskViewController *taskViewController = [[TaskViewController alloc] initWithMission:selectedMission];
    [self.navigationController pushViewController:taskViewController animated:YES];
    [taskViewController release];
    
    /*TrackDetailsViewController *trackViewController = [[TrackDetailsViewController alloc]
                                                       initWithNibName:@"TrackDetailsViewController" bundle:nil
                                                       mission:[obj objectForKey:@"Id"]
                                                       ];
    
    [self.navigationController pushViewController:trackViewController animated:YES];
    [trackViewController release];
    */
}

@end
