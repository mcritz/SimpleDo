#import <UIKit/UIKit.h>
#import "SFRestAPI.h"


/**
 This class is a details view implementation of the Mobile SDK workbook Tutorial, Cloud Tunes
 It contains additional examples of using nested queries and looping through the results
 returned from Database.com and Force.com
 To 'enable' this details view, you can uncomment out the initialization steps in RootViewController
 */
@interface TrackDetailsViewController : UIViewController <SFRestDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    
	NSString *theMissionId;
    NSString *theAlbumTitle;
	NSMutableArray *tracks;
    NSString *theAlbumDescription;
    NSString *theAlbumPrice;
	
	UILabel *lblPrice;
	UILabel *lblDescription;
	UITableView *tblTracks;
	UIPickerView *tracksSpinner;
}

@property(nonatomic, retain) NSString *theMissionId;
@property(nonatomic, retain) NSString *theAlbumTitle; 
@property(nonatomic, retain) NSString *theAlbumDescription;
@property(nonatomic, retain) NSString *theAlbumPrice;
@property (nonatomic, retain) NSMutableArray *tracks;


//custom init method that allows us to pass in the album id to be loaded
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil albumId:(NSString *)albumId albumTitle:(NSString *)albumTitle;

@property (nonatomic, retain) IBOutlet UILabel *lblPrice;
@property (nonatomic, retain) IBOutlet UILabel *lblDescription;
@property (nonatomic, retain) IBOutlet UITableView *tblTracks;
@property (nonatomic, retain) IBOutlet UIPickerView *tracksSpinner;

@end
