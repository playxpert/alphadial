//
//  iPhoneSpeedDialAppDelegate.h
//  iPhoneSpeedDial
//
//  Created by Geykel on 9/5/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class iPhoneSpeedDialViewController, LocalContact;

@interface iPhoneSpeedDialAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UITabBarController *tabBarController;
	
	NSMutableArray *localContactList;
	sqlite3 *database;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *localContactList;

@end

