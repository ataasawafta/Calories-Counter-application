#import "MainScreen.h"
#import "SWRevealViewController.h"
#import <UserNotifications/UserNotifications.h>
static DBManager * dbmanager;
static NSString * currentDate;
@interface MainScreen ()

@end
@implementation MainScreen
{
    NSArray *mainlist;
    NSString *email;
   float  calperday;
}
bool check =false;
@synthesize  Menu,date1,Food;
+(NSString *)  currentDate
{
    return currentDate;
}
+(DBManager *) Connection{
    return  dbmanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dbmanager =[[DBManager alloc] initWithDatabaseFilename:@"mydatabase.sql"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    email = [defaults objectForKey:@"email"];
    UNUserNotificationCenter *center =[UNUserNotificationCenter currentNotificationCenter ];
    UNAuthorizationOptions  options =UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options  completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        
        check =granted;
    }];
    
    
    
    mainlist=[[NSArray alloc] initWithObjects:@"Date",@"Food",@"Excersise",@"Water",@"State", nil];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.Menu setTarget: self.revealViewController];
        [self.Menu setAction: @selector(revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSArray *info= [dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select * from userInfo where email ='%@';",email]];

    
  calperday =0;
    float weight=[info[0][5] floatValue ];
    float  targetWeight=[info[0][6] floatValue];
    float Height = [ info[0][7] floatValue];
    int time=[info[0][8] intValue];
    NSString * age=info[0][3];
    age=[age substringToIndex:4];
    int ageintvalue= [age intValue];
    int currentage=2017-ageintvalue;
    if([info [0][4] isEqualToString:@"M"])
    {
        calperday=10*weight+6.25*Height-currentage*5 - 161;
    }
    else
    {
       calperday=10*weight+6.25*Height-currentage*5 - 5;
    }
    float ca=(500*time)/7;
    
    calperday=calperday-ca;
    
    _caloriesperDay.text=[[NSString alloc] initWithFormat:@"Calories per Day = %d",(int)calperday];
    _remainingCalories.text=[[NSString alloc]initWithFormat:@"remaining calories =%d",(int)calperday];
   [self DateChange];


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

    return [mainlist count];
}
-(void) DateChange
{
    
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *date=[[NSString stringWithFormat:@"%@",[df stringFromDate:date1.date]] componentsSeparatedByString:@""];
    
 currentDate=[date objectAtIndex:0];
    NSString *queryfood = [[NSString alloc] initWithFormat:@"select calories from Breakfast where datef='%@' and email='%@';",currentDate,email];
    NSArray * result =[dbmanager loadDataFromDB:queryfood];
    float count=0;
    for (int i=0;i<result.count;i++)
    {
        count+=[result[i][0] floatValue];
    }

    queryfood = [[NSString alloc] initWithFormat:@"select calories from Lunch where datef='%@' and email='%@';",currentDate,email];
    result =[dbmanager loadDataFromDB:queryfood];

    for (int i=0;i<result.count;i++)
    {
        count+=[result[i][0] floatValue];
    }
   queryfood = [[NSString alloc] initWithFormat:@"select calories from Dinner where datef='%@' and email='%@';",currentDate,email];
    result =[dbmanager loadDataFromDB:queryfood];
    
    for (int i=0;i<result.count;i++)
    {
        count+=[result[i][0] floatValue];
    }
    
    queryfood = [[NSString alloc] initWithFormat:@"select calories from Snack where datef='%@' and email='%@';",currentDate,email];
    result =[dbmanager loadDataFromDB:queryfood];
    
    for (int i=0;i<result.count;i++)
    {
        count+=[result[i][0] floatValue];
    }
    
    Food.detailTextLabel.text=[[NSString alloc] initWithFormat:@"%d Calories ",(int)count ];
    
    NSString *queryExe = [[NSString alloc] initWithFormat:@"select calories from Exercise where datef='%@'and email='%@';",currentDate,email];
    NSArray * result1 =[dbmanager loadDataFromDB:queryExe];
    float countex=0;
    for (int i=0;i<result1.count;i++)
    {
        countex+=[result1[i][0] integerValue];
    }
    _Execries.detailTextLabel.text=[[NSString alloc] initWithFormat:@"%d Calories ",(int)countex];
    
  
    float i=(count-countex);
     _remainingCalories.text=[[NSString alloc]initWithFormat:@"remaining calories =%d", (int)(calperday-i)];
    float j,k,q;
    j=calperday+(calperday*.5);
       
    k=(calperday+(calperday*.75));
    q=( calperday+(calperday*1));
    if(i <calperday)
    {
        _verygood.progressTintColor=[UIColor colorWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
        _good.progressTintColor=[UIColor whiteColor];
        _bad.progressTintColor=[UIColor whiteColor];
        _w.progressTintColor=[UIColor whiteColor];

    
    }
    else
if(i>calperday && i<j)
{
    _verygood.progressTintColor=[UIColor colorWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
    _good.progressTintColor=[UIColor colorWithRed:0.550 green:0.550 blue:0.557 alpha:1.000];
    _bad.progressTintColor=[UIColor whiteColor];
    _w.progressTintColor=[UIColor whiteColor];


}
else if(i>j && i< k)
{
    _verygood.progressTintColor=[UIColor colorWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
    _good.progressTintColor=[UIColor colorWithRed:0.550 green:0.550 blue:0.557 alpha:1.000];
    _bad.progressTintColor=[UIColor orangeColor];
    _w.progressTintColor=[UIColor whiteColor];


}
    
else
    if(  i>k &&i<q )
    {
        _verygood.progressTintColor=[UIColor colorWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
        _good.progressTintColor=[UIColor colorWithRed:0.550 green:0.550 blue:0.557 alpha:1.000];
        _bad.progressTintColor=[UIColor orangeColor];
        _w.progressTintColor=[UIColor whiteColor];
      if(check )
          
      {    UNUserNotificationCenter *center =[UNUserNotificationCenter currentNotificationCenter ];
          UNMutableNotificationContent * not =[[UNMutableNotificationContent alloc] init];
        
          not.title=@"calories ";
          not.subtitle=@"";
          not.body=@"";
          not.sound=[ UNNotificationSound defaultSound];
          UNTimeIntervalNotificationTrigger *time =[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:false];
          
          UNNotificationRequest * request =[UNNotificationRequest requestWithIdentifier:@"UNLocalNotification" content:not trigger:time];
          [center addNotificationRequest:request withCompletionHandler:nil];
          
      }
        
        
    }


    else
        
    {
        _verygood.progressTintColor=[UIColor colorWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
        _good.progressTintColor=[UIColor colorWithRed:0.550 green:0.550 blue:0.557 alpha:1.000];
        _bad.progressTintColor=[UIColor orangeColor];
        _w.progressTintColor=[UIColor redColor];
        
       if(check)
       {
               UNUserNotificationCenter *center =[UNUserNotificationCenter currentNotificationCenter ];
           
           UNMutableNotificationContent * not =[[UNMutableNotificationContent alloc] init];
           not.title=@"calories ";
           not.subtitle=@"";
           not.body=@"";
           not.sound=[ UNNotificationSound defaultSound];
            UNTimeIntervalNotificationTrigger *time =[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:false];
              UNNotificationRequest * request =[UNNotificationRequest requestWithIdentifier:@"UNLocalNotification1" content:not trigger:time];
       
         [center addNotificationRequest:request withCompletionHandler:nil];
           
       
       }
      
    }
    NSArray *water=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Water where email='%@' and datef='%@';",email,currentDate]];

if(water.count==0)
{
    int x=0;
    _Water.detailTextLabel.text=@"0";
    [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into Water Values ('%@','%d','%@')",email,x,currentDate]];
}
else
{
    _Water.detailTextLabel.text=[[NSString alloc]initWithFormat:@"%d",[water[0][1] intValue]];
}
}

-(IBAction)datechange:(id)sender
{
    [self DateChange];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==3)
{

        NSArray *water=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Water where email='%@' and datef='%@';",email,currentDate]];
  id count=water[0][1];
    UIAlertController * AddWater =[UIAlertController alertControllerWithTitle:@"Water" message:[[NSString alloc] initWithFormat:@"%@",count] preferredStyle:UIAlertControllerStyleAlert];
  
        UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"+"  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                             {
                            NSArray *water=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Water where email='%@' and datef='%@';",email,currentDate]];
                                 int count=[water[0][1] intValue];
                                 count++;
                                   [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Water set count='%d' where email='%@' and datef='%@';",count,email,currentDate]];
                                 
                                 
                                 [self DateChange];
                                 [tableView reloadData];
                             }
                             ];
        
        UIAlertAction *sub=[ UIAlertAction actionWithTitle:@"--" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                NSArray *water=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Water where email='%@' and datef='%@';",email,currentDate]];
                                int count=[water[0][1] intValue];
                            if(count>0)
                            {
                                count--;
                                [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Water set count='%d' where email='%@' and datef='%@';",count,email,currentDate]];
                                
                            }
                                [self DateChange];
                                [tableView reloadData];
                            
                            }
                            ];
        
    
        
        UIAlertAction *Cancel=[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                             {
                                 
                                 
                                 
                             }
                             
                             
                             ];
        [AddWater addAction:Add];
        [AddWater addAction: sub];
        [AddWater addAction:Cancel] ;
        [self presentViewController:AddWater animated:YES completion:nil];

   
    }

    }





@end
