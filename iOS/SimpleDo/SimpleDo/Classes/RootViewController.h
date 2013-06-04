/**
 * © 2013 Map of the Unexplored.
 * No warranty, written or implied, is given.
 * Use at your own peril.
 * Set the whole thing on fire and start over.
 */

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface RootViewController : UITableViewController <SFRestDelegate> {
    
    NSMutableArray *dataRows;
    IBOutlet UITableView *tableView;    

}

@property (nonatomic, retain) NSArray *dataRows;

@end