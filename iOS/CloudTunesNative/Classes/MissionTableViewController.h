//
//  MissionTableViewController.h
//  SimpleDo
//
//  Created by Michael Critz on 6/5/13.
//  Copyright (c) 2013 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMission.h"

@interface MissionTableViewController : UITableViewController <UITableViewDataSource>

- (UITableViewController *)initWithMission:(SFMission *)mission :(NSString *)nibNameOrNil :(NSBundle *)nibBundleOrNil;

@end