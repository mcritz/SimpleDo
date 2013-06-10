//
//  MissionDataRequest.m
//  SimpleDo
//
//  Created by Michael Critz on 6/9/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "MissionDataRequest.h"

#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"

@interface MissionDataRequest()
@property (nonatomic)NSString *userId;
@property (nonatomic)NSObject *objectToUpdate;
@end

@implementation MissionDataRequest
@synthesize allMissions = _allMissions;

- (NSMutableArray *)allMissions {
    if (!_allMissions) {
        _allMissions = [[NSMutableArray alloc] init];
    }
    return _allMissions;
}

- (MissionDataRequest *)initWithObject:(NSObject *)sender {
    self = [super init];
    if (self){
        self.objectToUpdate = sender;
        SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
        self.userId = idData.userId;
        [self getCloudMissions];
    }
    return self;
}
- (void)getCloudMissions {
    SFRestRequest *request;
    NSString *query = [NSString stringWithFormat:@"%@%@%@",
                       @"SELECT Id,Assigned_To__c,Name,Status__c, (select id, Status,Subject,WhatId, order__c from tasks where Status not in ('Cancelled') order by order__c desc) FROM Mission__c where Status__c<>'Failed' and Assigned_To__c='", self.userId,@"'"];
    request = [[SFRestAPI sharedInstance] requestForQuery:query];
    [[SFRestAPI sharedInstance] send:request delegate:self];
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
        NSMutableArray *tasksArray = [[[NSMutableArray alloc] init] autorelease];
        
        if( ![responseTasksObject isEqual:[NSNull null]] ) {
            NSDictionary *responseTasks = [responseTasksObject objectForKey:@"records"];
            for(NSMutableDictionary *singleTask in responseTasks){
                NSLog(@"singleTask %@", singleTask);
                SFTask *task = [[[SFTask alloc] initWithDictionary:singleTask] autorelease];
                
                [tasksArray addObject:task];
            }
        } else {
            NSLog(@"no tasks!");
            NSDictionary *noTasksDictionary = @{@"taskStatus": @"No tasks"};
            SFTask *task = [[SFTask alloc] initWithDictionary:[noTasksDictionary mutableCopy]];
            [tasksArray addObject:task];
        }
        SFMission* thisMission = [[[SFMission alloc] initWithMissionId:[record objectForKey:@"Id"] andName:[record objectForKey:@"Name"] andStatus:[record objectForKey:@"Status__c"] andTasks:tasksArray] autorelease];
        //      NSLog(@"thismission inside---%@",thisMission);
        [self.allMissions addObject:thisMission];
        //      NSLog(@"allmissions inside---%@",self.allMissions);
    }
    #pragma We can avoid this warning by creating a new subclass of UIViewController… if we had the time
    [self.objectToUpdate updateUI];
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



@end
