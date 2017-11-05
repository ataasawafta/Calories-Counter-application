
#import <UIKit/UIKit.h>
#import "MainScreen.h"
#import "DBManager.h"
@interface foodpa : UITableViewController
@property (retain,nonatomic) IBOutlet UITableViewCell *Lunch;
@property (retain,nonatomic) IBOutlet UITableViewCell *Dinner;
@property (retain,nonatomic) IBOutlet UITableViewCell *Snack;
-(IBAction)goback:(id)sender;

@property (retain ,nonatomic )IBOutlet UITableViewCell *breakFast;
@end
