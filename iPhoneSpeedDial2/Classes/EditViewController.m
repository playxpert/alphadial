//
//  EditViewController.m
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "LocalContact.h"
#import "Alpha_DialAppDelegate.h"
#import "ConfigureComboViewController.h"

#define kAccelerometerFrequency   25 //Hz
#define kFilteringFactor    0.1
#define kMinEraseInterval    0.5
#define kEraseAccelerationThreshold  1.0

@interface EditViewController ()

@property (nonatomic, retain) ConfigureComboViewController *configureComboViewController;
@property (nonatomic, retain) UINavigationController *configureComboNavigationController;
@property (nonatomic, retain) UINavigationItem *contactName;
@property (nonatomic, retain) LocalContact *currentLocalContact;
@property (nonatomic) NSInteger touchCount;
@property (nonatomic, retain) UIButton *buttonA;
@property (nonatomic, retain) UIButton *buttonB;
@property (nonatomic, retain) UIButton *buttonC;
@property (nonatomic, retain) UIButton *buttonD;
@property (nonatomic, retain) UIButton *buttonE;
@property (nonatomic, retain) UIButton *buttonF;
@property (nonatomic, retain) UIButton *buttonG;
@property (nonatomic, retain) UIButton *buttonH;
@property (nonatomic, retain) UIButton *buttonI;
@property (nonatomic, retain) UIButton *buttonJ;
@property (nonatomic, retain) UIButton *buttonK;
@property (nonatomic, retain) UIButton *buttonL;
@property (nonatomic, retain) UIButton *buttonM;
@property (nonatomic, retain) UIButton *buttonN;
@property (nonatomic, retain) UIButton *buttonO;
@property (nonatomic, retain) UIButton *buttonP;
@property (nonatomic, retain) UIButton *buttonQ;
@property (nonatomic, retain) UIButton *buttonR;
@property (nonatomic, retain) UIButton *buttonS;
@property (nonatomic, retain) UIButton *buttonT;
@property (nonatomic, retain) UIButton *buttonU;
@property (nonatomic, retain) UIButton *buttonV;
@property (nonatomic, retain) UIButton *buttonW;
@property (nonatomic, retain) UIButton *buttonX;
@property (nonatomic, retain) UIButton *buttonY;
@property (nonatomic, retain) UIButton *buttonZ;
@property (nonatomic, retain) NSString *lockedButton;

@end

@implementation EditViewController

@synthesize configureComboViewController, configureComboNavigationController;
@synthesize contactName, currentLocalContact, touchCount;
@synthesize buttonA;
@synthesize buttonB;
@synthesize buttonC;
@synthesize buttonD;
@synthesize buttonE;
@synthesize buttonF;
@synthesize buttonG;
@synthesize buttonH;
@synthesize buttonI;
@synthesize buttonJ;
@synthesize buttonK;
@synthesize buttonL;
@synthesize buttonM;
@synthesize buttonN;
@synthesize buttonO;
@synthesize buttonP;
@synthesize buttonQ;
@synthesize buttonR;
@synthesize buttonS;
@synthesize buttonT;
@synthesize buttonU;
@synthesize buttonV;
@synthesize buttonW;
@synthesize buttonX;
@synthesize buttonY;
@synthesize buttonZ;
@synthesize lockedButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
	}
	return self;
}

- (void)initAccelerometer {
	//Configure and enable the accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

- (IBAction)doClearContactLabel {
	NSLog(@"doClearContactLabel");
	if (self.currentLocalContact != nil) {
		self.currentLocalContact.combo = @"";
	}
	self.lockedButton = @"";
/*	if(self.lockedButton == nil || [self.lockedButton isEqualToString:@""]) {*/
		self.contactName.title = @"Select Letter";
/*	} else {
		self.contactName.title = [self.lockedButton stringByAppendingString:@" - Select Letter"];
	}*/
}

- (void)lockButton {
	NSLog(@"lockButton");
	if (lastButton != nil) {
		NSUInteger i = [self.currentLocalContact.combo length];
		NSString *letter = (i > 0 ? [self.currentLocalContact.combo substringFromIndex:(i - 1)] : @"");
		NSLog(letter);
		self.lockedButton = [NSString stringWithString:letter];
		[self loadCombo:lastButton];
	}
/*	if (self.touchCount == 0) {
		if (self.currentLocalContact == nil) {
			self.currentLocalContact = [[LocalContact alloc] init];
		}
		if (self.lockedButton == nil) {
			self.lockedButton = [[NSString alloc] init];
		}
		NSLog(self.currentLocalContact.combo);
		self.touchCount = 1;
		if (self.currentLocalContact.combo != nil) {
			NSUInteger i = [self.currentLocalContact.combo length];
			NSString *letter = (i > 0 ? [self.currentLocalContact.combo substringFromIndex:(i - 1)] : @"");
			NSLog(letter);
			self.lockedButton = [NSString stringWithString:letter];
		}
	} else {
		self.touchCount = 0;
		self.lockedButton = @"";
		[self doClearContactLabel];
	}*/
	NSLog(self.lockedButton);
}

- (IBAction)configureCombo:(id)sender {
	if (lastButton.tag >= 100) {
	[lastButton setImage: [imagesManager imageForIndex:lastButton.tag - 100 highlight:false] forState:UIControlStateNormal];
	[lastButton setImage: [imagesManager imageForIndex:lastButton.tag - 100 highlight:false] forState:UIControlStateHighlighted];
	}
	self.touchCount = 0;
	ConfigureComboViewController *controller = self.configureComboViewController;
	
	if (configureComboNavigationController == nil) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        self.configureComboNavigationController = navController;
        [navController release]; 
    }
		
    [self.tabBarController presentModalViewController:configureComboNavigationController animated:YES];
	
	[controller setEditing:NO animated:NO];
	[controller clickedButton:self.currentLocalContact.combo];

	[controller loadContact];
	[self doClearContactLabel];
	[self AutoRefresh];
}

- (ConfigureComboViewController *)configureComboViewController {
    if (configureComboViewController == nil) {
        configureComboViewController = [[ConfigureComboViewController alloc] initWithNibName:@"ConfigureComboView" bundle:nil];
    }
    return configureComboViewController;
}

- (IBAction)loadCombo:(id)sender {
	if (self.currentLocalContact == nil ) {
		self.currentLocalContact = [[LocalContact alloc] init];
	}
	if (self.lockedButton == nil) {
		self.lockedButton = [[NSString alloc] init];
	}
	//self.touchCount = 1;
	self.currentLocalContact.combo = [self.lockedButton stringByAppendingString:[sender currentTitle]]; 
	[self loadContact:self.currentLocalContact.combo];

/*	if (self.touchCount == 0) {
		if (self.currentLocalContact == nil ) {
			self.currentLocalContact = [[LocalContact alloc] init];
		}
		self.currentLocalContact.combo = [sender currentTitle]; 
		[self loadContact:[sender currentTitle]];
	}
	else {
		self.touchCount = 0;
		self.currentLocalContact.combo = [self.currentLocalContact.combo stringByAppendingString:[sender currentTitle]]; 

		[self loadContact:self.currentLocalContact.combo];
	}
 */
}

-(void)loadContact:(NSString *) button {
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	self.currentLocalContact = [delegate getByCombo:self.currentLocalContact];
	if (self.currentLocalContact.primaryKey != 0) {
		[self fillContactLabel];
	}
	else {
		self.contactName.title = [ self.currentLocalContact.combo stringByAppendingString:@" - Unassigned"];
	}
}

- (void)fillContactLabel {
	
	ABAddressBookRef addressBook = ABAddressBookCreate();
	ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, self.currentLocalContact.primaryKey);
	NSString* fn = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	NSString* ln = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	if (fn || ln)
		self.contactName.title = [[self.currentLocalContact.combo stringByAppendingString:@" - "] stringByAppendingString:[fn ? fn : @"" stringByAppendingString:[NSString stringWithFormat:@" %@", ln ? ln : @""]]];
	else {
		NSString* org = (NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
		self.contactName.title = [[self.currentLocalContact.combo stringByAppendingString:@" - "] stringByAppendingString:org];
	}
	
	[fn release];
	[ln release];
}

- (IBAction)clearContactLabel {
	if (lastButton != nil) {
		[self configureCombo:lastButton];
	}	
	[self doClearContactLabel];
	[self AutoRefresh];
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
	[imagesManager release];
	[configureComboNavigationController release];
	if (instructionsViewController != nil) {
		[instructionsViewController release];
	}
	[super dealloc];
}

- (InstructionsViewController *)instructionsViewController {
    if (instructionsViewController == nil) {
        instructionsViewController = [[InstructionsViewController alloc] initWithNibName:@"InstructionsView" bundle:nil];
    }
    return instructionsViewController;
}

- (IBAction)showInstructions {
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:delegate.tabBarController.view cache:YES];
	[delegate.tabBarController.view addSubview:[self instructionsViewController].view];
	[UIView commitAnimations];
}


- (void) awakeFromNib {
	emptyBackgroundImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"empty_combo_background" ofType:@"png" inDirectory:@"/"]] retain];
	notEmptyBackgroundImage = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"not_empty_combo_background" ofType:@"png" inDirectory:@"/"]] retain];;
	imagesManager = [[ImagesManager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
	[self initAccelerometer];
	[self AutoRefresh];
}

// Called when the accelerometer detects motion
- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	UIAccelerationValue length, x, y, z;
	
	//Use a basic high-pass filter to remove the influence of the gravity
	myAccelerometerX = acceleration.x * kFilteringFactor + myAccelerometerX * (1.0 - kFilteringFactor);
	myAccelerometerY = acceleration.y * kFilteringFactor + myAccelerometerY * (1.0 - kFilteringFactor);
	myAccelerometerZ = acceleration.z * kFilteringFactor + myAccelerometerZ * (1.0 - kFilteringFactor);
	// Compute values for the three axes of the acceleromater
	x = acceleration.x - myAccelerometerX;
	y = acceleration.y - myAccelerometerY;
	z = acceleration.z - myAccelerometerZ;
	
	//Compute the intensity of the current acceleration 
	length = sqrt(x * x + y * y + z * z);
	lastTime = CFAbsoluteTimeGetCurrent();
	
	// If above a given threshold - it's a shake
	if((length >= kEraseAccelerationThreshold) && (CFAbsoluteTimeGetCurrent() < (lastTime + kMinEraseInterval))) {
		[self lockButton];
		[self AutoRefresh];
	}
}

- (void)notEmptyBackground:(UIButton *) button {
	[button setBackgroundImage:notEmptyBackgroundImage forState:UIControlStateNormal];
	[button setBackgroundImage:notEmptyBackgroundImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:notEmptyBackgroundImage forState:UIControlStateSelected];
}

- (void)emptyBackground:(UIButton *) button {
	[button setBackgroundImage:emptyBackgroundImage forState:UIControlStateNormal];
	[button setBackgroundImage:emptyBackgroundImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:emptyBackgroundImage forState:UIControlStateSelected];
}

- (void)highlighButtons {
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	NSMutableArray * localContactArray = delegate.localContactList;
	
	
	[self emptyBackground:self.buttonA];
	[self emptyBackground:self.buttonB];
	[self emptyBackground:self.buttonC];
	[self emptyBackground:self.buttonD];
	[self emptyBackground:self.buttonE];
	[self emptyBackground:self.buttonF];
	[self emptyBackground:self.buttonG];
	[self emptyBackground:self.buttonH];
	[self emptyBackground:self.buttonI];
	[self emptyBackground:self.buttonJ];
	[self emptyBackground:self.buttonK];
	[self emptyBackground:self.buttonL];
	[self emptyBackground:self.buttonM];
	[self emptyBackground:self.buttonN];
	[self emptyBackground:self.buttonO];
	[self emptyBackground:self.buttonP];
	[self emptyBackground:self.buttonQ];
	[self emptyBackground:self.buttonR];
	[self emptyBackground:self.buttonS];
	[self emptyBackground:self.buttonT];
	[self emptyBackground:self.buttonU];
	[self emptyBackground:self.buttonV];
	[self emptyBackground:self.buttonW];
	[self emptyBackground:self.buttonX];
	[self emptyBackground:self.buttonY];
	[self emptyBackground:self.buttonZ];
	int highlighButtonIndex = 0;
	if ((self.lockedButton != nil) && ([self.lockedButton length] > 0)) {
		highlighButtonIndex = 1;
	}
	for (LocalContact *aLocalContact in localContactArray) {
		if ((highlighButtonIndex == 0) || ((highlighButtonIndex == 1) && ([aLocalContact.combo rangeOfString:lockedButton].location == 0))) {
			if ([aLocalContact.combo rangeOfString:@"A"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonA];
			} else if ([aLocalContact.combo rangeOfString:@"B"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonB];
			} else if ([aLocalContact.combo rangeOfString:@"C"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonC];
			} else if ([aLocalContact.combo rangeOfString:@"D"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonD];
			} else if ([aLocalContact.combo rangeOfString:@"E"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonE];
			} else if ([aLocalContact.combo rangeOfString:@"F"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonF];
			} else if ([aLocalContact.combo rangeOfString:@"G"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonG];
			} else if ([aLocalContact.combo rangeOfString:@"H"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonH];
			} else if ([aLocalContact.combo rangeOfString:@"I"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonI];
			} else if ([aLocalContact.combo rangeOfString:@"J"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonJ];
			} else if ([aLocalContact.combo rangeOfString:@"K"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonK];
			} else if ([aLocalContact.combo rangeOfString:@"L"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonL];
			} else if ([aLocalContact.combo rangeOfString:@"M"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonM];
			} else if ([aLocalContact.combo rangeOfString:@"N"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonN];
			} else if ([aLocalContact.combo rangeOfString:@"O"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonO];
			} else if ([aLocalContact.combo rangeOfString:@"P"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonP];
			} else if ([aLocalContact.combo rangeOfString:@"Q"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonQ];
			} else if ([aLocalContact.combo rangeOfString:@"R"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonR];
			} else if ([aLocalContact.combo rangeOfString:@"S"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonS];
			} else if ([aLocalContact.combo rangeOfString:@"T"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonT];
			} else if ([aLocalContact.combo rangeOfString:@"U"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonU];
			} else if ([aLocalContact.combo rangeOfString:@"V"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonV];
			} else if ([aLocalContact.combo rangeOfString:@"W"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonW];
			} else if ([aLocalContact.combo rangeOfString:@"X"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonX];
			} else if ([aLocalContact.combo rangeOfString:@"Y"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonY];
			} else if ([aLocalContact.combo rangeOfString:@"Z"].location == highlighButtonIndex) {
				[self notEmptyBackground:self.buttonZ];
			}
		}
	}
	
}

-(void)AutoRefresh {
	[self highlighButtons];
}

- (IBAction)touchDragInside:(id)sender withEvent:(id)event{

	UIEvent *localEvent = (UIEvent *) event;
	UITouch *touch = (UITouch *) [[localEvent allTouches] anyObject];
	if (touch != nil) {
		if (touch.view) {
			CGPoint point = [touch locationInView:self.view];
//			[sender hitTest:point withEvent:event];
			UIView *new = [self.view hitTest:point withEvent:event];
			if (new.tag >= 100) {
				
				UIButton *button = ((UIButton *)new);
				if (lastButton != button) {
					if (lastButton != nil) {
						[lastButton setImage: [imagesManager imageForIndex:lastButton.tag - 100 highlight:false] forState:UIControlStateNormal];
						[lastButton setImage: [imagesManager imageForIndex:lastButton.tag - 100 highlight:false] forState:UIControlStateHighlighted];
					}
					[button setImage: [imagesManager imageForIndex:button.tag - 100 highlight:true] forState:UIControlStateNormal];
					[button setImage: [imagesManager imageForIndex:button.tag - 100 highlight:true] forState:UIControlStateHighlighted];
					[self loadCombo:new]; 
					lastButton = button;
				}
			}
		}
	}
}

@end
