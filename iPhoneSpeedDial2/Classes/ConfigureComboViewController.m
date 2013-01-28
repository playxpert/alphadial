//
//  ConfigureComboViewController.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ConfigureComboViewController.h"
#import "Alpha_DialAppDelegate.h"
#import "LocalContact.h";

@interface ConfigureComboViewController ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) NSString *clickedButton;
@property (nonatomic, copy) NSIndexPath *contactIndexPath;
@property (nonatomic, copy) NSIndexPath *comboIndexPath;
@property (nonatomic, retain) UILabel *valueNameRef;
@property (nonatomic, retain) UILabel *valuePhoneRef;
@property (nonatomic, retain) UILabel *valueComboRef;
@property (nonatomic, retain) LocalContact *currentLocalContact;
@property (nonatomic, retain) UIButton *deleteButton;

@end

@implementation ConfigureComboViewController

@synthesize tableView;
@synthesize clickedButton;
@synthesize contactIndexPath;
@synthesize comboIndexPath;
@synthesize currentLocalContact;
@synthesize valueNameRef;
@synthesize valuePhoneRef;
@synthesize valueComboRef;
@synthesize deleteButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Configure Combo";
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

- (void)viewDidLoad {
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																						   target:self action:@selector(cancel:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																							target:self action:@selector(save:)] autorelease];
	self.navigationItem.rightBarButtonItem.enabled = NO;
	self.deleteButton.enabled = NO;

}
-(void)loadContact {
	self.currentLocalContact = [[LocalContact alloc] init];
	self.currentLocalContact.combo = self.clickedButton; 
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	self.currentLocalContact = [delegate getByCombo:self.currentLocalContact];
	
	if (self.currentLocalContact.primaryKey != 0) {
		self.deleteButton.enabled = YES;

		[self fillValueLabels];
	}
	else if (self.currentLocalContact.primaryKey == 0) {
		[self clearValueLabels];
	}
	
}
- (void)fillValueLabels {
	if (self.currentLocalContact.primaryKey != 0) {
		ABAddressBookRef addressBook = ABAddressBookCreate();
		ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, self.currentLocalContact.primaryKey);
		NSString* fn = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSString* ln = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
		if (fn || ln)
			self.valueNameRef.text = [fn ? fn : @"" stringByAppendingString:[NSString stringWithFormat:@" %@", ln ? ln : @""]];
		else {
			NSString* org = (NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
			self.valueNameRef.text = org;
		}
		
		self.valuePhoneRef.text = self.currentLocalContact.phone;
	}
	self.valueComboRef.text = self.clickedButton;

}
- (void)clearValueLabels {
	self.valueNameRef.text = @"";
	self.valuePhoneRef.text = @"";
	self.valueComboRef.text = self.clickedButton;
}
- (IBAction)cancel:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
	self.navigationItem.rightBarButtonItem.enabled = NO;
	self.deleteButton.enabled = NO;
}

- (IBAction)save:(id)sender {
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	[delegate saveContact:self.currentLocalContact];
	self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (IBAction)delete:(id)sender {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Confirmation" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil]; 
	[alert show]; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex ==1) {
		Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
		[delegate deleteContact:self.currentLocalContact];
		self.deleteButton.enabled = NO;
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
	[alertView release];
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.navigationItem setHidesBackButton:editing animated:animated];
	
}
- (void)clickedButton: (NSString *) button {
	self.clickedButton = button;
}

- (void)dealloc {
	[tableView release];
	[super dealloc];
}

#pragma mark -
#pragma mark <UITableViewDelegate, UITableViewDataSource> Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
		UILabel *labelName, *valueName, *labelPhone, *valuePhone, *valueCombo;
		if (indexPath.section == 1 ) {
			self.contactIndexPath = indexPath;
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
			labelName = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 5.0, 260, 20.0)] autorelease];
			labelName.tag = 1;		
			labelName.font = [UIFont systemFontOfSize:20.0];
			//labelName.textAlignment = UITextAlignmentLeft;
			labelName.textColor = [UIColor blueColor];
			//labelName.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
			labelName.text = @"Full Name:";
			[cell.contentView addSubview:labelName];
			
			valueName = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 25.0, 260.0, 30.0)] autorelease];
			valueName.tag = 2;
			valueName.font = [UIFont boldSystemFontOfSize:26.0];
			valueName.textColor = [UIColor blackColor];
			//valueName.lineBreakMode = UILineBreakModeWordWrap;
			//valueName.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			self.valueNameRef = valueName;
			[cell.contentView addSubview:valueName];
			
			labelPhone = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 60.0, 260.0, 20.0)] autorelease];
			labelPhone.tag = 3;		
			labelPhone.font = [UIFont systemFontOfSize:20.0];
			//labelPhone.textAlignment = UITextAlignmentRight;
			labelPhone.textColor = [UIColor blueColor];
			//labelPhone.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
			labelPhone.text = @"Phone:";
			[cell.contentView addSubview:labelPhone];
			
			valuePhone = [[[UILabel alloc] initWithFrame:CGRectMake(10.0, 80.0, 260.0, 23.0)] autorelease];
			valuePhone.tag = 4;
			valuePhone.font = [UIFont boldSystemFontOfSize:26.0];
			valuePhone.textColor = [UIColor blackColor];
			valuePhone.lineBreakMode = UILineBreakModeWordWrap;
			//valuePhone.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			self.valuePhoneRef = valuePhone;
			[cell.contentView addSubview:valuePhone];
		}
		else {
			self.comboIndexPath = indexPath;

			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
			
			valueCombo = [[[UILabel alloc] initWithFrame:CGRectMake(50.0, 7.0, 200.0, 30.0)] autorelease];
			valueCombo.tag = 2;
			valueCombo.font = [UIFont boldSystemFontOfSize:56.0];
			valueCombo.textColor = [UIColor blackColor];
			valueCombo.lineBreakMode = UILineBreakModeWordWrap;
			valueCombo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			self.valueComboRef = valueCombo;
			[cell.contentView addSubview:valueCombo];	
			
		}
    }
	if (self.contactIndexPath != nil && self.comboIndexPath != nil) {
		[self fillValueLabels];
	}
	return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Combo";
        case 1: return @"Contact Info";
    }
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section==1) ? indexPath : nil;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
	return (indexPath.section==1) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)newIndexPath {
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
		if (newIndexPath.section == 1) {
				ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
				picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];

				picker.peoplePickerDelegate = self;
				[self presentModalViewController:picker animated:YES];
				[picker release];
		}
}
- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {

    return YES;
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker  shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property
							  identifier:(ABMultiValueIdentifier)identifier{
		
	NSString* name = (NSString *)ABRecordCopyValue(person,kABPersonFirstNameProperty);
	NSString* name2 = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	
	if (name || name2)
		self.valueNameRef.text = [name ? name : @"" stringByAppendingString:[NSString stringWithFormat:@" %@", name2 ? name2 : @""]];
	else {
		NSString* org = (NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
		self.valueNameRef.text = org;
	}
	
	[name release];
	[name2 release];
	
	ABMultiValueRef mvr = ABRecordCopyValue(person, kABPersonPhoneProperty); 
	name = (NSString *)ABMultiValueCopyValueAtIndex( mvr, ABMultiValueGetIndexForIdentifier(mvr, identifier) );
	self.valuePhoneRef.text = name;
	[name release];
	if (self.currentLocalContact == nil ) {
		self.currentLocalContact = [[LocalContact alloc] init];
	}
	if (![self.currentLocalContact.phone isEqualToString:self.valuePhoneRef.text] || self.currentLocalContact.primaryKey != ABRecordGetRecordID(person))
		self.navigationItem.rightBarButtonItem.enabled = YES;
	
	self.currentLocalContact.primaryKey = ABRecordGetRecordID(person);
	self.currentLocalContact.combo = self.clickedButton;
	self.currentLocalContact.phone = self.valuePhoneRef.text;
	[self dismissModalViewControllerAnimated:YES];
	
	
    return NO;
	
}


@end
