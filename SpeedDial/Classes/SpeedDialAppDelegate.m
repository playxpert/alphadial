
#import "SpeedDialAppDelegate.h"

@implementation SpeedDialAppDelegate

@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	[window addSubview:navigationController.view];	
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end
