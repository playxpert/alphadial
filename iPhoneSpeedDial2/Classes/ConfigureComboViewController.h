//
//  ConfigureComboViewController.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "LocalContact.h"


@interface ConfigureComboViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate, UIAlertViewDelegate> {
	IBOutlet UITableView *tableView;
	IBOutlet NSString *clickedButton;
	IBOutlet NSIndexPath *contactIndexPath;
	IBOutlet NSIndexPath *comboIndexPath;
	IBOutlet LocalContact *currentLocalContact;
	IBOutlet UILabel *valueNameRef;
	IBOutlet UILabel *valuePhoneRef;
	IBOutlet UILabel *valueComboRef;
	IBOutlet UIButton *deleteButton;
	
}
- (void)loadContact;
- (void)fillValueLabels;
- (void)clearValueLabels;
- (void)clickedButton: (NSString *) button;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)delete:(id)sender;

@end
