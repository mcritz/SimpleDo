//
//  SFMission.h
//  CloudTunesNative
//
//  Created by Prashanth Reddy Kambalapally on 5/25/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SFRestAPI.h"


@interface SFMission : NSObject<SFRestDelegate>{
}
@property (strong,nonatomic) NSMutableDictionary *thisMissionTasks;
@property (strong,nonatomic) NSString* thisMissionId;
@property (strong,nonatomic) NSString* thisMissionName;
@property (strong,nonatomic) NSString* thisMissionStatus;
-(NSDictionary*)querySFDC:(NSString*)userId;
-(id)initWithMissionId: (NSString* )missionId andName:missionName andStatus:missionStatus andTasks:(NSMutableDictionary*)tasks;
-(NSString*)updateTask: (NSString*)taskId withStatus:(NSString* )taskStatus;
@end