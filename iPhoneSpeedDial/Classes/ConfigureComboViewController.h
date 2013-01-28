//
//  ConfigureComboViewController.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigureComboViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableView;
}

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
