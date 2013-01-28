
#import <UIKit/UIKit.h>

@class SpeedDialViewController;

@interface SpeedDialAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
    IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

