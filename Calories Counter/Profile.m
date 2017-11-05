

#import "Profile.h"
#import "MainScreen.h"
#import "DBManager.h"

@interface Profile ()

@end

@implementation Profile
{
    DBManager * dbmanager;
    NSArray * profilelist;
    NSString *email;
    NSString *birth;
    NSString * gender;
}
@synthesize  back,save;
@synthesize profileImage;
@synthesize  Weight,Time,TargetWeight,Name,Password,Email,male,Female,Height,birthday;

-(IBAction)male:(id)sender{
    Female.layer.cornerRadius =false;
    male.layer.cornerRadius = self.male.frame.size.width / 2;
   male.layer.masksToBounds=true;
gender=@"M";
}
-(IBAction)female:(id)sender
{
   male.layer.cornerRadius =false;
   Female.layer.cornerRadius = self.Female.frame.size.width / 2;
Female.layer.masksToBounds=true;
    gender=@"F";
    
}

-(IBAction)profileImage:(id)sender
{
  
    
}

-(IBAction)Date:(id)sender
{
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *date=[[NSString stringWithFormat:@"%@",[df stringFromDate:birthday.date]] componentsSeparatedByString:@""];
    birth=[date objectAtIndex:0];

}
-(IBAction)back:(id)sender
{
    UIViewController * to_Main =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
    [self presentViewController:to_Main animated:YES completion:nil];
}
-(IBAction)save:(id)sender
{
    
   
  
    NSString *query=[[NSString alloc ]initWithFormat:@"select * from userInfo where email='%@';",email];
    NSArray *result =[dbmanager loadDataFromDB:query];
  
    if(result.count !=0){
       
        float weight=[result[0][5] floatValue];
        
        if(![Weight.text isEqualToString:@""])
    { weight =[Weight.text floatValue];
    }
    
    float targetweight=[result[0][6] floatValue ];
    if(![TargetWeight.text isEqualToString:@""])
   
    {
  targetweight= [TargetWeight.text floatValue];
    }
    

        
    float height=[result [0][7] floatValue];
    if(![Height.text isEqualToString:@""])
    {
    height=[Height.text floatValue];
    }
    int time=[result [0][8] intValue];
     
    if(![Time.text isEqualToString:@""])
    {
       time =[Time.text intValue];
    }
    
    NSString * name=result[0][0];
    if(![Name.text isEqualToString:@""])
    {
        name=  Name.text;
    }

  NSString * password =result[0][2] ;
       NSLog(@"password = %@",password);
    if(![Password.text isEqualToString:@""])
    {
      password= Password.text;
        
    }
        char ge;
        if([gender isEqualToString:@"M"])
            ge='M';
        else
            ge='F';
      
    [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update userInfo set  name='%@' , password='%@',Gender='%c',Birthday='%@',Weight ='%f', TargetWeight='%f', Height='%f' ,Time ='%d' where email='%@';",name,password,ge,birth, weight,targetweight,height,time,email]];//
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    Password.secureTextEntry=YES;
    profilelist =[[NSArray alloc] initWithObjects:@"image",@"Name",@"Email",@"Password",@"BirthDay",@"Gender",@"Weight",@"TargetWeight",@"Height",@"Time", nil];
    dbmanager=[MainScreen Connection];

    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    email=[defaults objectForKey:@"email"];
    
    
    NSString *query=[[NSString alloc ]initWithFormat:@"select * from userInfo where email='%@';",email];
       NSArray *result =[dbmanager loadDataFromDB:query];
   
    Name.text=result[0][0];

   Email.text=result[0][1];
    Password.text=result[0][2];
   
    NSString *st =result[0][3] ;
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [f dateFromString:st];
    [birthday setDate:date];

     gender=result[0][4];

   if([gender isEqualToString:@"M"])
   {
       male.layer.cornerRadius = self.male.frame.size.width / 2;
       male.layer.masksToBounds=true;
       Female.layer.cornerRadius =false;
       gender=@"M";
   
   }
   else
   {
       
    male.layer.cornerRadius =false;
    Female.layer.cornerRadius = self.Female.frame.size.width / 2;
    Female.layer.masksToBounds=true;
    gender=@"F";
   
   }
    Weight.text=result[0][5] ;
    TargetWeight.text =result[0][6] ;
    Height.text=result[0][7];
    Time.text=result[0][8];
    profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    profileImage.layer.masksToBounds=true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [profilelist count];
}



@end
