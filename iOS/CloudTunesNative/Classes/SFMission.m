//
//  SFMission.m
//  Created by Prashanth Reddy Kambalapally on 5/25/13.
//  © 2013 Map of the Unexplored
//

#import "SFMission.h"

#import "SFMission.h"
#import "SFRestAPI.h"
#import "SFAccountManager.h"
#import "SFIdentityData.h"
#import "SFTask.h"

@interface SFMission()
@property (nonatomic) NSString* userId;
@end
@implementation SFMission

//@synthesize tasks;
@synthesize thisMissionId;

-(id)initWithMissionId: (NSString* )missionId andName:missionName andStatus:missionStatus andTasks:(NSMutableDictionary*)tasks
{
//    self.thisMissionTasks = [tasks copy];
    // NSLog(@"thisMissionTasks %@", self.thisMissionTasks);
    self.thisMissionId = missionId;
    self.thisMissionName = missionName;
    self.thisMissionStatus = missionStatus;
    SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
    self.userId = idData.userId;
    self.tasks = [tasks copy];
    return self;
}

//Lazy initialization of the missions
//-(NSMutableDictionary *)thisMissionTasks
//{
//    if(!_thisMissionTasks)_thisMissionTasks = [[NSMutableDictionary alloc] init];
//    return _thisMissionTasks;
//}

//-(NSDictionary*)querySFDC:(NSString*)userId
//{
//    SFRestRequest *request;
//    NSString* queryString = [NSString stringWithFormat:@"%@%@%@",
//                             @"SELECT Assigned_To__c,Name,Status__c FROM Mission__c where Assigned_To__c='", self.userId,@"'"];
//    
//    request = [[SFRestAPI sharedInstance] requestForQuery:queryString];
//    
//    [[SFRestAPI sharedInstance] send:request delegate:self];
//    return nil;
//}

-(NSString*)updateTask: (NSString*)taskId withStatus:(NSString* )taskStatus
{
    SFRestRequest *updateTaskRequest;
    //NSString* queryString = [NSString stringWithFormat:@"%@%@%@",
    //                        @"SELECT Assigned_To__c,Name,Status__c FROM Mission__c where Assigned_To__c='", self.userId,@"'"];
    
    updateTaskRequest = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:@"Task" objectId:taskId fields:[[NSMutableDictionary alloc] initWithObjectsAndKeys:taskStatus, @"Status", nil]];
    [[SFRestAPI sharedInstance] send:updateTaskRequest delegate:self];
    return @"Success";
}

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    
	NSMutableArray *allDetails = [response objectForKey:@"records"];
	
    //database.com returns additional information such as attributes and number of results
    //we want the actual response...
    //NSDictionary *results = [allDetails objectAtIndex:0];
	
    NSLog(@"allDetails----%@",allDetails);
    
	//payload is returned as JSON. If the value of a textfield is null, Objective-C will represent this as a NSNull object.
	//Printing it to the console will show as "<null>".
	//This is different from nil,so let's check for NSNull
    
    /*	theAlbumDescription = [results objectForKey:@"Description__c"];
     if ([theAlbumDescription isEqual:[NSNull null]]) {
     [lblDescription setText:@"No description available"];
     }
     else {
     [lblDescription setText:theAlbumDescription];
     }
     
     theAlbumPrice = [results objectForKey:@"Price__c"];
     
     //if (theAlbumPrice == 0) {
     //	[lblPrice setText:@"Free!"];
     //}
     [lblPrice setText:[NSString stringWithFormat:@"$%@", theAlbumPrice]];
     
     
     NSDictionary *allTracks =[results objectForKey:@"Tracks__r"];
     
     if (![allTracks isEqual:[NSNull null]]) {
     self.tracks = [allTracks objectForKey:@"records"];
     [self.tracksSpinner reloadAllComponents];
     }
     */
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



@end
