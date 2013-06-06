//
//  SFTask.m
//  SimpleDo
//
//  Created by Michael Critz on 6/4/13.
//  ©2013 Map of the Unexplored
//

#import "SFTask.h"

@implementation SFTask

-(SFTask *)initWithDictionary:(NSDictionary *)taskDefinition {
    NSLog(@"SFTask init taskDefinition: %@", taskDefinition);
    self.taskId     = [taskDefinition valueForKey:@"Id"];
    self.taskOrder  = [taskDefinition valueForKey:@"Order__c"];
    self.taskStatus = [taskDefinition valueForKey:@"Status"];
    self.taskSubject= [taskDefinition valueForKey:@"Subject"];
    self.taskWhatId = [taskDefinition valueForKey:@"WhatId"];
    self.taskType   = [taskDefinition valueForKey:@"type"];
    self.taskUrl    = [taskDefinition valueForKey:@"url"];
    return self;
}

@end
