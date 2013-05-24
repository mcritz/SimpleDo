//
//  SFMission.h
//  SFMobileApp2013
//
//  Created by Prashanth Reddy Kambalapally on 5/23/13.
//  Copyright (c) 2013 SFDC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestAPI.h"

@interface SFMission : NSObject<SFRestDelegate>{
}
@property (strong,nonatomic) NSDictionary *missionsWithTasks;
-(NSDictionary*)querySFDC:(NSString*)userId;

@end
