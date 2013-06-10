#import "RootViewController.h"

#import "MissionDataRequest.h"

#import "SFMission.h"
#import "SFTask.h"
#import "MissionTableViewController.h"

@interface RootViewController()
@property (nonatomic) NSString* userId;
@property (nonatomic)MissionDataRequest *missionData;
@end

@implementation RootViewController

//Lazy initialization of the missions

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.missionData = [[MissionDataRequest alloc] initWithObject:self];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    UIColor *brandColor = [UIColor colorWithRed:0.18 green:0.20 blue:0.30 alpha:1];
    [self.navigationController.navigationBar setTintColor:brandColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                UITextAttributeFont:[UIFont fontWithName:@"AvenirNext-HeavyItalic" size:22],
                                           UITextAttributeTextColor:[UIColor colorWithRed:1 green:.56 blue:.29 alpha:1],
                                     UITextAttributeTextShadowColor:[UIColor blackColor]
     }];
    [self setTitle:@"Missions"];
    [self.tableView setSeparatorColor:[UIColor colorWithWhite:.7 alpha:1]];

    [self updateUI];
    [super viewDidLoad];
}

- (void)updateUI{
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.missionData.allMissions count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UI
    [cell.textLabel setTextColor:[UIColor colorWithWhite:.3 alpha:1]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:18]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    SFMission *obj = [self.missionData.allMissions objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.thisMissionName;
    
    //add the arrow to the right hand side
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




#pragma mark - Mobile SDK additional samples
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *obj = [self.allMissions objectAtIndex:indexPath.row];
    NSString *aid = [obj objectForKey:@"Id"];
    NSString *objectType = @"Album__c";
    SFRestRequest *request;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete from the cloud
        // TODO: fix leak
        request = [[SFRestAPI sharedInstance] requestForDeleteWithObjectType:objectType objectId:aid];
        
        
        SFRestRequest *request = [SFRestRequest requestWithMethod:SFRestMethodDELETE path:aid queryParams:nil];
        
        //in our sample app, once a delete is done, we are done, thus no delegate callback
        [[SFRestAPI sharedInstance] send:request delegate:nil];
        
        //delete the row from the array
        [self.allMissions removeObject:obj];
        
        // Delete the row from the table
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}
*/

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SFMission *selectedMission = [self.missionData.allMissions objectAtIndex:indexPath.row];
    NSLog(@"selected mission in didselectrow----%@",selectedMission);
    UITableViewController *missionTVC = [[MissionTableViewController alloc] initWithMission:selectedMission :@"MissionTableViewController" :nil];
    [self.navigationController pushViewController:missionTVC animated:YES];
    [missionTVC release];
}

@end
