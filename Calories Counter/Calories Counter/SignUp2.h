#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "SignUp1.h"
 DBManager *dbmanager;
@interface SignUp2 : UITableViewController
@property (nonatomic ,retain ) IBOutlet UITextField * Weight;
@property (nonatomic ,retain) IBOutlet UITextField *TargetWeight;
@property (nonatomic ,retain )IBOutlet UITextField *hieght ;
@property (nonatomic ,retain) IBOutlet UITextField *time;
@property (nonatomic ,retain) IBOutlet UILabel *massageWeight;
@property (nonatomic ,retain) IBOutlet UILabel *massageHieght;
@property (nonatomic ,retain )IBOutlet UILabel * massagetime;
@property (nonatomic ,retain) IBOutlet UILabel * massagetargetWeight;
@property (nonatomic ,retain )IBOutlet UITextField * ID;
-(IBAction)CreateAccount:(UIBarButtonItem *)sender;
@end
