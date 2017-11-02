#import <UIKit/UIKit.h>
@interface Exercise : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain,nonatomic) IBOutlet UIBarButtonItem *back;
@property (nonatomic ,retain) IBOutlet UISegmentedControl * foodCon;
@property (retain,nonatomic) IBOutlet UISegmentedControl * exercisecontrol;
@property (retain ,nonatomic )IBOutlet UITableView *tableView;
- (IBAction)buttonPressed:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)addnewExercise:(id)sender;
@end

