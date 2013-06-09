//
//  SFMission.h
//  Created by Prashanth Reddy Kambalapally on 5/25/13.
//  © 2013 Map of the Unexplored
//

#import <Foundation/Foundation.h>

#import "SFRestAPI.h"

@interface SFMission : NSObject<SFRestDelegate>
@property (strong,nonatomic) NSString* thisMissionId;
@property (strong,nonatomic) NSString* thisMissionName;
@property (strong,nonatomic) NSString* thisMissionStatus;
// -(NSDictionary*)querySFDC:(NSString*)userId;
-(id)initWithMissionId: (NSString* )missionId andName:missionName andStatus:missionStatus andTasks:(NSArray *)tasks;
// -(NSString*)updateTask: (NSString*)taskId withStatus:(NSString* )taskStatus;
@property (nonatomic, retain)NSMutableArray *tasks;
@end
