//
//  EditViewController.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalContact.h"
#import "InstructionsViewController.h"
#import "ImagesManager.h";

@class ConfigureComboViewController;

@interface EditViewController : UIViewController <UIAccelerometerDelegate> {
	ConfigureComboViewController *configureComboViewController;
	UINavigationController *configureComboNavigationController;
	IBOutlet UINavigationItem *contactName;
	IBOutlet LocalContact *currentLocalContact;
	NSInteger touchCount;
	InstructionsViewController *instructionsViewController;
	IBOutlet UIButton *buttonA;
	IBOutlet UIButton *buttonB;
	IBOutlet UIButton *buttonC;
	IBOutlet UIButton *buttonD;
	IBOutlet UIButton *buttonE;
	IBOutlet UIButton *buttonF;
	IBOutlet UIButton *buttonG;
	IBOutlet UIButton *buttonH;
	IBOutlet UIButton *buttonI;
	IBOutlet UIButton *buttonJ;
	IBOutlet UIButton *buttonK;
	IBOutlet UIButton *buttonL;
	IBOutlet UIButton *buttonM;
	IBOutlet UIButton *buttonN;
	IBOutlet UIButton *buttonO;
	IBOutlet UIButton *buttonP;
	IBOutlet UIButton *buttonQ;
	IBOutlet UIButton *buttonR;
	IBOutlet UIButton *buttonS;
	IBOutlet UIButton *buttonT;
	IBOutlet UIButton *buttonU;
	IBOutlet UIButton *buttonV;
	IBOutlet UIButton *buttonW;
	IBOutlet UIButton *buttonX;
	IBOutlet UIButton *buttonY;
	IBOutlet UIButton *buttonZ;
	UIImage *emptyBackgroundImage;
	UIImage *notEmptyBackgroundImage;
	UIButton *lastButton;
	ImagesManager *imagesManager;

	NSString *lockedButton;
	float myAccelerometerX;
	float myAccelerometerY;
	float myAccelerometerZ;
	CFAbsoluteTime lastTime;
	
}

- (IBAction)configureCombo:(id)sender;
- (IBAction)loadCombo:(id)sender;
-(void)loadContact:(NSString *) button;
- (void)fillContactLabel;
- (IBAction)clearContactLabel;
- (IBAction)showInstructions;
-(void)AutoRefresh;
- (IBAction)touchDragInside:(id)sender withEvent:(id)event;

@end