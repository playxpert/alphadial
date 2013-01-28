//
//  EditViewController.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "iPhoneSpeedDialAppDelegate.h"
#import "ConfigureComboViewController.h"

@interface EditViewController ()

@property (nonatomic, retain) ConfigureComboViewController *configureComboViewController;
@property (nonatomic, retain) UINavigationController *configureComboNavigationController;

@end

@implementation EditViewController

@synthesize configureComboViewController, configureComboNavigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (IBAction)configureCombo:(id)sender {
	ConfigureComboViewController *controller = self.configureComboViewController;
	
	if (configureComboNavigationController == nil) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        self.configureComboNavigationController = navController;
        [navController release];
    }
    [self.tabBarController presentModalViewController:configureComboNavigationController animated:YES];
	
	[controller setEditing:YES animated:NO];
}

- (ConfigureComboViewController *)configureComboViewController {
    if (configureComboViewController == nil) {
        configureComboViewController = [[ConfigureComboViewController alloc] initWithNibName:@"ConfigureComboView" bundle:nil];
    }
    return configureComboViewController;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[configureComboNavigationController release];
	[super dealloc];
}


@end
