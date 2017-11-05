
#import <UIKit/UIKit.h>

@interface SnackDisplay : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(IBAction)back:(id)sender;
@end
