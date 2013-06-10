//
//  MissionDataRequest.h
//  SimpleDo
//
//  Created by Michael Critz on 6/9/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import "SFRestRequest.h"
#import "SFMission.h"
#import "SFTask.h"

@interface MissionDataRequest : NSObject <SFRestDelegate>

@property (nonatomic, retain)NSMutableArray *allMissions;
- (MissionDataRequest *)initWithObject:(NSObject *)sender;

@end
