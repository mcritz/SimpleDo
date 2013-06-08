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
#import "NewTaskViewController.h"

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
    
    SFRestRequest *updateTaskRequest;    
    updateTaskRequest = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:@"Task" objectId:self.taskId fields:[[NSMutableDictionary alloc] initWithObjectsAndKeys:status, @"Status", nil]];
    [[SFRestAPI sharedInstance] send:updateTaskRequest delegate:self];
}

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    NSLog(@"response %@", response);
    // TODO: [response description] should be parsed and pass a legit "yeah, I completed"
    [self.taskVC didUpdateTask:@"Complete"];
}

+(void)createTask:(NewTaskViewController *)sender withMissionId:(NSString*)missionId andSubject:(NSString*)subject
{
    SFIdentityData* idData = [[SFAccountManager sharedInstance] idData];
    NSString* userId = idData.userId;
    NSLog(@"missionID,userId,subject%@,%@,%@",missionId,userId,subject);
    SFRestRequest *createTaskReq = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:@"Task" fields:[[NSDictionary alloc] initWithObjectsAndKeys:userId,@"OwnerId",missionId,@"whatId",subject,@"Subject", nil]];
    
    [[SFRestAPI sharedInstance] send:createTaskReq delegate:self];
}

@end
