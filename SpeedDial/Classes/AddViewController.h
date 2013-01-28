
#import <UIKit/UIKit.h>


@interface AddViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableView;
}

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
