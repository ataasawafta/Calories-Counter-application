

#import "SignUp1.h"

@interface SignUp1 ()

@end
static  NSString *Name;
static NSString *Email;
static NSString *Password;
static      NSString*Date1;
static char Gender;
@implementation SignUp1
{
    NSArray *Signupcell;
    UIBarButtonItem *Next,*Back ;
   char maleorfemale; // m male , w female
}

+(NSString * )Name
{ return Name;
}
+(NSString *)Email{return Email;}
+(NSString *) BirthDay{return Date1;}
+(char)Gender{return Gender;}
+(NSString *) password{
    return Password;
}

@synthesize email;
@synthesize confirmemail;
@synthesize password;

@synthesize BirthDay;

@synthesize massage_name, massage_email,massage_password,massage_confirm_email;
;
@synthesize  confirmpassword,massage_confirmpassword;

@synthesize  male,female;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     
    self.title=@"Sign Up ";
 
    Signupcell =[[NSArray alloc] initWithObjects:@"Name",@"Email",@"ConfirmEmail",@"Password",@"ConfirmPassword",@"Gender",@"BirthDay", nil];
    female.layer.cornerRadius =true;
     female.layer.cornerRadius = self.female.frame.size.width /.3;
    male.layer.cornerRadius = self.male.frame.size.width / 2;
    male.layer.masksToBounds=true;
    maleorfemale='M';
    _name.layer.cornerRadius=5;
    _name.layer.masksToBounds=true;
    
    email.layer.cornerRadius=5;
    email.layer.masksToBounds=true;
    confirmemail.layer.cornerRadius=5;
    confirmemail.layer.masksToBounds=true;
    password.layer.cornerRadius=5;
    password.layer.masksToBounds=true;
    confirmpassword.layer.cornerRadius=5;
    confirmpassword.layer.masksToBounds=true;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Signupcell count];
}



-(IBAction)male:(id)sender{
    female.layer.cornerRadius =false;
    male.layer.cornerRadius = self.male.frame.size.width / 2;
    male.layer.masksToBounds=true;
    maleorfemale='M';
    }


-(IBAction)female:(id)sender{
    
    male.layer.cornerRadius =false;
    female.layer.cornerRadius = self.female.frame.size.width / 2;
    female.layer.masksToBounds=true;
    maleorfemale='W';
}
-(IBAction)Next:(id)sender
{
    if(![self.name.text isEqual:@""] &&![self.email.text isEqual:@""]&&![self.confirmemail.text isEqual:@""] &![self.password.text isEqual:@""] &&![self.confirmpassword.text isEqual:@""])
    {
if([self.email.text isEqual:confirmemail.text]&&[self.password.text isEqual: confirmpassword.text])
{

    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *date=[[NSString stringWithFormat:@"%@",[df stringFromDate:BirthDay.date]] componentsSeparatedByString:@""];
    
    NSString* currentDate=[date objectAtIndex:0];
    Name=_name.text;
    Email=email.text;
    Password=password.text;
    Gender=maleorfemale;
    Date1=currentDate;
    NSLog(@"%@",currentDate);
    UIViewController * to_Signup2 =[self.storyboard  instantiateViewControllerWithIdentifier :@"navSignUp2"];
    [self presentViewController:to_Signup2 animated:YES completion:nil];
 
}
else
    {
        
        if(![self.email.text isEqual:confirmemail.text])
        {
            
            massage_email.text=massage_confirm_email.text=@"Not Equal!!!";
        }
       else
       {
           password.text=confirmpassword.text=@"Not Equal!!!";
       }
        
        
    }
    
    }
    else
    {
        if([email.text isEqualToString:@""])
        {
         massage_email.text=@"Enter Email !!";
        }
        if([password.text isEqualToString:@""])
        {
            password.text=@"Enter Password !!";
        }
        if([ confirmpassword.text isEqualToString:@""])
        {
            confirmpassword.text=@"Enter Password!! ";
            
        }
        if([confirmemail.text isEqualToString:@""])
        {massage_confirm_email .text=@"Enter email !!";
            
        }
        if([self.name.text isEqual:@""] )
        {
            massage_name.text=@"Enter Name";
            
        }
        
        
        
    }
    
}

@end
