
#import <UIKit/UIKit.h>

@class ContactsViewController, AddViewController;

@interface MasterViewController : UIViewController {
	ContactsViewController *contactsViewController;
	AddViewController *addViewController;
	UINavigationController *addNavigationController;
}

- (IBAction)viewContacts:(id)sender;
- (IBAction)addContact:(id)sender;

@end
