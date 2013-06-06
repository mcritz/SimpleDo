//
//  SFTask.m
//  SimpleDo
//
//  Created by Michael Critz on 6/4/13.
//  ©2013 Map of the Unexplored
//

#import "SFTask.h"
#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"
#import "TaskViewController.h"

@interface SFTask()

@property (nonatomic) NSString *userId;
@property (nonatomic) TaskViewController *taskVC;
@end

@implementation SFTask

-(SFTask *)initWithDictionary:(NSDictionary *)taskDefinition {
    NSLog(@"SFTask init taskDefinition: %@", taskDefinition);
    self.taskId     = [taskDefinition valueForKey:@"Id"];
//    self.taskOrder  = [taskDefinition valueForKey:@"Order__c"];
    self.taskStatus = [taskDefinition valueForKey:@"Status"];
    self.taskSubject= [taskDefinition valueForKey:@"Subject"];
//    self.taskWhatId = [taskDefinition valueForKey:@"WhatId"];
//    self.taskType   = [taskDefinition valueForKey:@"type"];
//    self.taskUrl    = [taskDefinition valueForKey:@"url"];
    return self;
}

- (void)updateTask:(NSString *)status :(TaskViewController *)sender {
    self.taskVC = sender;
    SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
    self.userId = idData.userId;
    
    //Here we use a query that should work on either Force.com or Database.com
    /*SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Name FROM User LIMIT 10"];
     [[SFRestAPI sharedInstance] send:request delegate:self];
     */
    SFRestRequest *request;
    
    // TODO: need this query to UPDATE task Status to Completed using the "status" & "Id"
    NSString* queryString = [NSString stringWithFormat:@"%@%@%@",
                             @"SELECT Assigned_To__c,Name,Status__c, (select id, Status,Subject,WhatId, order__c from tasks where Status not in ('Completed','Cancelled')) FROM Mission__c where Assigned_To__c='", self.userId,@"'"];
    
    request = [[SFRestAPI sharedInstance] requestForQuery:queryString];
    
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    NSLog(@"response %@", response);
    // TODO: [response description] should be parsed and pass a legit "yeah, I completed"
    [self.taskVC didUpdateTask:[response description]];
}

@end
