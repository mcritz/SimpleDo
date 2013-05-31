//
//  TaskViewController.h
//  CloudTunesNative
//
//  Created by Prashanth Reddy Kambalapally on 5/31/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMission.h"

@interface TaskViewController : UIViewController
- (id)initWithMission:(SFMission *)mission;
@property (strong,nonatomic) SFMission* selectedMission;
@end
