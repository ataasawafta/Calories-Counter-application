
#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface ViewController : UIViewController
@property (nonatomic,retain) DBManager *dbmanager;
@property (retain,nonatomic) IBOutlet UILabel*massage;
@property (retain,nonatomic) IBOutlet UITextField * email;
@property (retain,nonatomic) IBOutlet UITextField * password;
@property (retain,nonatomic) IBOutlet UIButton *forgetpassword;
@property (retain,nonatomic) IBOutlet UIButton *login;
@property (retain ,nonatomic) IBOutlet UIButton *CreateNewAccount;

@property (retain,nonatomic) IBOutlet UILabel * name;

///////////function
-(IBAction)forgetAccount:(id)sender;
-(IBAction)logIn:(id)sender;


@end

