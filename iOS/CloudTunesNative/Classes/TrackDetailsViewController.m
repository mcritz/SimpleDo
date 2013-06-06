#import "TrackDetailsViewController.h"


@implementation TrackDetailsViewController
@synthesize lblPrice;
@synthesize lblDescription;
@synthesize tblTracks;
@synthesize tracksSpinner;

@synthesize theMissionId;
@synthesize theAlbumPrice;
@synthesize theAlbumDescription;
@synthesize theAlbumTitle; 
@synthesize tracks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil missionId:(NSString *)missionId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		//theMissionId = theMissionId;
        
        
        //theAlbumTitle = albumTitle;
		//self.title = theAlbumTitle;
		
//        NSString *queryString =  [NSString stringWithFormat:@"%@%@%@", 
//                                  @"select Name, Released_On__c, Description__c, Price__c, (select name, price__c from Tracks__r) from Album__c where id = '", theAlbumId,@"'"];
//        
//        SFRestRequest *request;
//        request = [[SFRestAPI sharedInstance] requestForQuery:queryString];
//        
//        [[SFRestAPI sharedInstance] send:request delegate:self];
    }
    return self;
}

- (void)dealloc
{
	[lblPrice release];
	[lblDescription release];
	[tblTracks release];
	[tracksSpinner release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setLblPrice:nil];
	[self setLblDescription:nil];
	[self setTblTracks:nil];
	[self setTracksSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)response {
    
	NSMutableArray *allDetails = [response objectForKey:@"records"];
	
    //database.com returns additional information such as attributes and number of results
    //we want the actual response...
    NSDictionary *results = [allDetails objectAtIndex:0];
	
    
	//payload is returned as JSON. If the value of a textfield is null, Objective-C will represent this as a NSNull object.
	//Printing it to the console will show as "<null>". 
	//This is different from nil,so let's check for NSNull
    
	theAlbumDescription = [results objectForKey:@"Description__c"];
    if ([theAlbumDescription isEqual:[NSNull null]]) {
		[lblDescription setText:@"No description available"];
	}
	else {
		[lblDescription setText:theAlbumDescription];
    }
	
    theAlbumPrice = [results objectForKey:@"Price__c"];
	
	//if (theAlbumPrice == 0) {
	//	[lblPrice setText:@"Free!"];
	//}
	[lblPrice setText:[NSString stringWithFormat:@"$%@", theAlbumPrice]];
	
    
   NSDictionary *allTracks =[results objectForKey:@"Tracks__r"];
    
	if (![allTracks isEqual:[NSNull null]]) {
		self.tracks = [allTracks objectForKey:@"records"];
		[self.tracksSpinner reloadAllComponents];
	}
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    
    //here is a sample of handling errors neatly.
    NSLog(@"RootViewController:didFailWithError: %@", error);
    
    // show alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Database.com Error" 
                                                    message:[NSString stringWithFormat:@"Problem retrieving data %@", error]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}


#pragma mark pickerview delegate events

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [self.tracks count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	NSDictionary *obj = [tracks objectAtIndex:row];
    return [obj objectForKey:@"Name"];

}

@end
