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

@synthesize thisMissionId;

-(id)initWithMissionId: (NSString* )missionId andName:missionName andStatus:missionStatus andTasks:(NSMutableDictionary*)tasks
{
    self.thisMissionId = missionId;
    self.thisMissionName = missionName;
    self.thisMissionStatus = missionStatus;
    SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
    self.userId = idData.userId;
    self.tasks = [tasks mutableCopy];
    return self;
}


- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
	NSMutableArray *allDetails = [response objectForKey:@"records"];
    NSLog(@"allDetails----%@",allDetails);
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
