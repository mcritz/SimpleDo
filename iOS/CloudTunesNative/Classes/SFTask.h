//
//  SFTask.h
//  SimpleDo
//
//  Created by Michael Critz on 6/4/13.
//  ©2013 Map of the Unexplored
//

#import <Foundation/Foundation.h>

@interface SFTask : NSObject

@property (nonatomic, retain)NSString *taskId;
//@property (nonatomic, retain)NSString *taskOrder;
//@property (nonatomic, retain)NSString *taskStatus;
@property (nonatomic, retain)NSString *taskSubject;
//@property (nonatomic, retain)NSString *taskWhatId;
//@property (nonatomic, retain)NSString *taskType;
//@property (nonatomic, retain)NSString *taskUrl;

-(SFTask *)initWithDictionary:(NSMutableDictionary *)taskDefinition;

@end