#import "InstructionsViewController.h"
#import "Alpha_DialAppDelegate.h"

@implementation InstructionsViewController

- (IBAction) hideView {
	Alpha_DialAppDelegate *delegate = (Alpha_DialAppDelegate *) [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:delegate.tabBarController.view cache:YES];
	[self.view removeFromSuperview];
	[UIView commitAnimations];
}

@end
