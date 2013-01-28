//
//  DialViewController.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalContact.h"
#import "InstructionsViewController.h"
#import "ImagesManager.h"


@interface DialViewController : UIViewController <UIAccelerometerDelegate> {
	IBOutlet UINavigationItem *contactName;
	IBOutlet LocalContact *currentLocalContact;
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
	IBOutlet UIButton *buttonQST;
	IBOutlet UIButton *buttonEXC;
	NSInteger touchCount;
	IBOutlet UIView *dialView;
	InstructionsViewController *instructionsViewController;
	
	NSString *lockedButton;
	float myAccelerometerX;
	float myAccelerometerY;
	float myAccelerometerZ;
	CFAbsoluteTime lastTime;
	
	UIImage *emptyBackgroundImage;
	UIImage *notEmptyBackgroundImage;
	ImagesManager *imagesManager;
	UIButton *lastButton;
}
- (IBAction)loadCombo:(id)sender;
- (IBAction)dialToContact;
-(void)loadContact:(NSString *) button;
- (void)fillContactLabel;
- (IBAction)clearContactLabel;
- (IBAction)showInstructions;
-(void)AutoRefresh;
- (IBAction)touchDrag:(id)sender withEvent:(id)event;

@end
