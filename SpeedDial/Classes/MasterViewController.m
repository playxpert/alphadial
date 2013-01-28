
#import "MasterViewController.h"
#import "SpeedDialAppDelegate.h"
#import "ContactsViewController.h"
#import "AddViewController.h"

@interface MasterViewController ()

@property (nonatomic, retain) ContactsViewController *contactsViewController;
@property (nonatomic, retain) AddViewController *addViewController;
@property (nonatomic, retain) UINavigationController *addNavigationController;

@end

@implementation MasterViewController

@synthesize contactsViewController, addViewController, addNavigationController;

- (IBAction)viewContacts:(id)sender {
	ContactsViewController *controller = self.contactsViewController;
	[self.navigationController pushViewController:controller animated:YES];
	[controller setEditing:NO animated:NO];
}

- (IBAction)addContact:(id)sender {
	AddViewController *controller = self.addViewController;
		
	if (addNavigationController == nil) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        self.addNavigationController = navController;
        [navController release];
    }
    [self.navigationController presentModalViewController:addNavigationController animated:YES];
		
	[controller setEditing:YES animated:NO];
}

- (ContactsViewController *)contactsViewController {
    if (contactsViewController == nil) {
        contactsViewController = [[ContactsViewController alloc] initWithNibName:@"ContactsView" bundle:nil];
    }
    return contactsViewController;
}

- (AddViewController *)addViewController {
    if (addViewController == nil) {
        addViewController = [[AddViewController alloc] initWithNibName:@"AddView" bundle:nil];
    }
    return addViewController;
}

- (void)dealloc {
	[addNavigationController release];
	[super dealloc];
}


@end
