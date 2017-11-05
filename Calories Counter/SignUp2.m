
#import "SignUp2.h"
#import "DBManager.h"
@interface SignUp2 ()

@end

@implementation SignUp2
{
    NSArray *SignUpcell;
}

@synthesize  Weight,massageWeight,TargetWeight,massagetargetWeight,hieght,massageHieght,time,massagetime,ID;

- (void)viewDidLoad {
    [super viewDidLoad];
      dbmanager =[[DBManager alloc] initWithDatabaseFilename:@"mydatabase.sql"];
    self.title=@"Sign Up";
    SignUpcell =[[NSArray alloc]initWithObjects:@"Weight",@"TargetWeight",@"Height",@"Time",@"id", nil];
    Weight.layer.cornerRadius=5;
    Weight.layer.masksToBounds=true;
    TargetWeight.layer.cornerRadius=5;
    TargetWeight.layer.masksToBounds=true;
   hieght.layer.cornerRadius=5;
    hieght.layer.masksToBounds=true;
    time.layer.cornerRadius=5;
    time.layer.masksToBounds=true;
    ID.layer.cornerRadius=5;
    ID.layer.masksToBounds=true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(IBAction)CreateAccount:(UIBarButtonItem *)sender
{

    if(![Weight.text isEqualToString:@""]&&![TargetWeight.text isEqualToString:@""] &&![hieght.text isEqualToString:@""] &&! [time.text isEqualToString:@""] && ![ID.text isEqualToString:@""])
    {

        
        NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from userInfo where email='%@';",[SignUp1 Email]]];
        if(rs.count==0)
        {
        [dbmanager executeQuery:[NSString stringWithFormat: @"insert into userInfo values ('%@','%@','%@','%@','%c','%f','%f','%f','%d','%@');",[SignUp1 Name] ,[SignUp1 Email],[SignUp1 password],[SignUp1 BirthDay],[SignUp1 Gender],Weight.text.floatValue,TargetWeight.text.floatValue,hieght.text.floatValue,time.text.intValue,[ID text]]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[SignUp1 Email] forKey:@"email"];
            [defaults setObject:[SignUp1 Name] forKey:@"name"];
        [defaults synchronize];
        UIViewController * to_Main =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
        [self presentViewController:to_Main animated:YES completion:nil];
        }
        else
            
        {
            UIAlertController * password1 =[UIAlertController alertControllerWithTitle:@"email" message:@"Email is found , please enter  aonther one  " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok1 =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ok)
                                 {
                                     
                                 }];
            [password1 addAction:ok1];
            
            [self presentViewController:password1 animated:YES completion:nil];
            
            
        }
    }
    else
    {
        if([Weight.text isEqualToString:@""])
        {
            massageWeight.text=@" Enter Weight !!";
        }
        if([TargetWeight.text isEqualToString:@""])
        {
            massagetargetWeight.text=@"Enter Target Weight!! ";
        }
        if([hieght.text isEqualToString:@""])
        {
            
            massageHieght.text=@"Enter Height!! ";
        }
        if([time.text isEqualToString:@""])
        {
        massagetime.text=@"Enter Time !!";
        }
    }
    
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [SignUpcell count];
}






@end
