#import "foodpa.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface foodpa ()

@end

@implementation foodpa
{
    NSDate*currentDate;
    DBManager *dbmanager;
    NSArray * part;
    NSString *email;
}
@synthesize  Lunch,Dinner,Snack,breakFast;
- (void)viewDidLoad {
[super viewDidLoad];
    part = [[NSArray alloc] initWithObjects:@"image",@"BreakFast",@"Lunch",@"Dinner",@"Snack", nil];
    dbmanager =[MainScreen Connection];
    currentDate=[MainScreen currentDate];
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    email = [defaults objectForKey:@"email"];
    [self DataChanage];

}
-(void) DataChanage{

       NSString *query=[[NSString alloc] initWithFormat:@"select calories from Breakfast where datef='%@' and email='%@';",currentDate,email];
     NSArray *result=[dbmanager loadDataFromDB:query];
     int count=0;
     for(int i=0;i<result.count ;i++)
     {
     count+= [result[i][0] integerValue];
     }
     breakFast.detailTextLabel.text=[[NSString alloc]initWithFormat: @"%d Calories " ,count];
     
     query=[[NSString alloc] initWithFormat:@"select calories from Lunch where datef='%@' and email='%@';",currentDate,email];
     result=[dbmanager loadDataFromDB:query];
     count=0;
     for(int i=0;i<result.count ;i++)
     {
     count+= [result[i][0] integerValue];
     }
     Lunch.detailTextLabel.text=[[NSString alloc]initWithFormat: @"%d Calories " ,count];
     
     NSString  *query1=[[NSString alloc] initWithFormat:@"select calories from Dinner where datef='%@' and email='%@';",currentDate,email];
     NSArray*  result1=[dbmanager loadDataFromDB:query1];
     int count1=0;
     for(int i=0;i<result1.count ;i++)
     {
     count1+= [result1[i][0] integerValue];
     }
     Dinner.detailTextLabel.text=[[NSString alloc]initWithFormat: @"%d Calories " ,count1];
     
     query=[[NSString alloc] initWithFormat:@"select calories from Snack  where datef='%@' and email='%@';",currentDate,email];
     result=[dbmanager loadDataFromDB:query];
     count=0;
     for(int i=0;i<result.count ;i++)
     {
     count+= [result[i][0] integerValue];
     }
     Snack.detailTextLabel.text=[[NSString alloc]initWithFormat: @"%d Calories " ,count];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [part count];
}
-(IBAction)goback:(id)sender
{
    UIViewController * to_Main =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
    [self presentViewController:to_Main animated:YES completion:nil];
}
@end
