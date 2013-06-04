/**
 * © 2013 Map of the Unexplored.
 * No warranty, written or implied, is given.
 * Use at your own peril.
 * Set the whole thing on fire and start over.
 */

#import "AppDelegate.h"
#import "RootViewController.h"

/*
 NOTE if you ever need to update these, you can obtain them from your Salesforce org,
 (When you are logged in as an org administrator, go to Setup -> Develop -> Remote Access -> New )
 */


// Fill these in when creating a new Remote Access client on Force.com 
static NSString *const RemoteAccessConsumerKey = @"3MVG9Iu66FKeHhINkB1l7xt7kR8czFcCTUhgoA8Ol2Ltf1eYHOU4SqQRSEitYFDUpqRWcoQ2.dBv_a1Dyu5xa";
static NSString *const OAuthRedirectURI = @"testsfdc:///mobilesdk/detect/oauth/done";


@implementation AppDelegate


#pragma mark - Remote Access / OAuth configuration


- (NSString*)remoteAccessConsumerKey {
    return RemoteAccessConsumerKey;
}

- (NSString*)oauthRedirectURI {
    return OAuthRedirectURI;
}



#pragma mark - App lifecycle


//NOTE be sure to call all super methods you override.


- (UIViewController*)newRootViewController {
    RootViewController *rootVC = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [rootVC release];
    
    return navVC;
}


@end
