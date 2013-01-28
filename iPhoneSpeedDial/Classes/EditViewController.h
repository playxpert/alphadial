//
//  EditViewController.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfigureComboViewController;

@interface EditViewController : UIViewController {
	ConfigureComboViewController *configureComboViewController;
	UINavigationController *configureComboNavigationController;
}

- (IBAction)configureCombo:(id)sender;

@end
