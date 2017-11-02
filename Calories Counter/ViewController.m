
#import "ViewController.h"
#import "DBManager.h"
@interface ViewController ()

@end


@implementation ViewController

@synthesize  dbmanager;
@synthesize massage;
@synthesize email;
@synthesize password;
@synthesize forgetpassword;
@synthesize login;
@synthesize  CreateNewAccount;


-(IBAction)forgetAccount:(id)sender
{

    UIAlertController * forgetpassword1 =[UIAlertController alertControllerWithTitle:@"Forget Password" message:@"" preferredStyle:UIAlertControllerStyleAlert];
  
    [forgetpassword1  addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter Email";
    }];
    [forgetpassword1  addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter ID";
    }];
    UIAlertAction * ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ok)
                         {
                             
                             
                             NSArray *rs = [dbmanager loadDataFromDB:[[ NSString alloc]initWithFormat:  @"select * from userInfo where email ='%@';",forgetpassword1.textFields[0].text]];
                             NSString * IDD =forgetpassword1.textFields[1].text;
                             
                             if(rs.count==1)
                             {
                                 
                                 NSString*R= rs[0][9];
                                 if([R isEqualToString:IDD])
                                 {
                                      UIAlertController * password1 =[UIAlertController alertControllerWithTitle:@" Password" message:[[NSString alloc]initWithFormat:@"%@",rs[0][2]] preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *ok1 =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ok)
                                                        {
                                                          
                                                        }];
                                     [password1 addAction:ok1];
                                   
                                       [self presentViewController:password1 animated:YES completion:nil];
                                     
                                 }
                                 
                             
                             else{
                               
                                     UIAlertController * password1 =[UIAlertController alertControllerWithTitle:@"Password" message:@"No such User Here  " preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction *ok1 =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ok)
                                                          {
                                                              
                                                          }];
                                     [password1 addAction:ok1];
                                     
                                     [self presentViewController:password1 animated:YES completion:nil];
                             }
                             }
                             else
                             {
                                 UIAlertController * password1 =[UIAlertController alertControllerWithTitle:@"Password" message:@"No such User Here" preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction *ok1 =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ok)
                                                      {
                                                          
                                                      }];
                                 [password1 addAction:ok1];
                                 
                                 [self presentViewController:password1 animated:YES completion:nil];
                             }
                         
                         
                         }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * cancel )
                             {
                            
                                 
                             }
                             ];
    [forgetpassword1 addAction:ok];
    [forgetpassword1 addAction:cancel];
    
    [self presentViewController:forgetpassword1 animated:YES completion:nil];}
-(IBAction)logIn:(id)sender
{
    if(![email.text isEqualToString:@""]&&![password.text isEqualToString:@""] )
    {
        massage.text=@"";
        NSString * emaildata= self.email.text ;
        NSError *error = NULL;
        NSRegularExpression *regex = nil;
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,6}"
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:&error];
        NSInteger valid=[regex numberOfMatchesInString:emaildata
                                               options:0
                                                 range:NSMakeRange(0, [emaildata length])];
        if(valid >=1)
        {
            NSString *passwordtext=self.password.text;
            NSString *query =[NSString stringWithFormat:@"select * from userInfo where Email='%@' and Password='%@';",emaildata,passwordtext];
            NSArray *result=nil;
            result=[dbmanager  loadDataFromDB:query];
          
            if(result.count >=1 )
            {
            ViewController * toMain =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
            [self presentViewController:toMain animated:YES completion:nil];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *name=result[0][0];
                [defaults setObject:emaildata forKey:@"email"];
                [defaults setObject:name forKey:@"name"];
            
            }
            
            else
            {
                
             massage.text=@"please enter correct data.";
            }
        }//IF VALID
        else
        {
            massage.text=@"please enter correct  data.";
            
            email.text=@"";
            password.text=@"";

            
        }//ELSE IF VALID
    }
    else
    {
        self.massage.text=@"please enter all required data.";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    password.secureTextEntry=true;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main.png"]];
    dbmanager =[[DBManager alloc] initWithDatabaseFilename:@"mydatabase.sql"];
    login.layer.cornerRadius=5;
    login.layer.masksToBounds=true;
    CreateNewAccount.layer.cornerRadius=5;
    CreateNewAccount.layer.masksToBounds=true;
    email.layer.cornerRadius=5;
    email.layer.masksToBounds=true;
    password.layer.cornerRadius=5;
    password.layer.masksToBounds=true;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
