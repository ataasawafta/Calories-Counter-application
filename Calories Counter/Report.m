#import "Report.h"
#import "cellCollectionViewCell.h"
#import "MainScreen.h"
@interface Report ()

@end
 static NSMutableArray * color;
static int i=0;
@implementation Report
{
    NSArray *calenderdate;
   DBManager *dbmanager;
     float  calperday;
    NSString *email;
    
  
}
@synthesize  back,Date;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    return calenderdate.count;
}
-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cellCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

 cell.backgroundColor=[UIColor  whiteColor];
cell.layer.borderWidth=10.0f;
cell.layer.borderColor=(__bridge CGColorRef _Nullable)(([UIColor blackColor]));
cell.backgroundColor=color[indexPath.row];
   
    if ([cell.contentView subviews]) {
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    label.text = [calenderdate objectAtIndex:indexPath.row];
    [cell.contentView addSubview:label];
    
    
    return cell;
}
-(IBAction)Back:(id)sender
{
    UIViewController * to_Main =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
    [self presentViewController:to_Main animated:YES completion:nil];
    
}
-(void)getcolor:(NSString *)month :(NSString *)year :(int )i :(NSMutableArray *)color
{
    
    NSArray *info= [dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select * from userInfo where email ='%@';",email]];
    
    
    calperday =0;
    int weight=[info[0][5] intValue ];
    int  targetWeight=[info[0][6] intValue];
    int Height = [ info[0][7] intValue];
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
    int ca=(500*time)/7;

    calperday=calperday-ca;
    for(int i=0;i<31;i++)
    { NSString *day;
        if(i<10)
       day=[[NSString alloc ] initWithFormat:@"0%d",i+1];
        else
            day=[[NSString alloc ] initWithFormat:@"%d",i+1];
       NSString* currentDate =[[NSString alloc ] initWithFormat:@"%@-%@-%@",year,month,day];
        NSLog(@"%@",currentDate);
        NSString *queryfood = [[NSString alloc] initWithFormat:@"select calories from Breakfast where datef='%@' and email='%@';",currentDate,email];
        NSArray * result =[dbmanager loadDataFromDB:queryfood];
        int count=0;
        for (int i=0;i<result.count;i++)
        {
            count+=[result[i][0] integerValue];
        }
        
        queryfood = [[NSString alloc] initWithFormat:@"select calories from Lunch where datef='%@' and email='%@';",currentDate,email];
        result =[dbmanager loadDataFromDB:queryfood];
        
        for (int i=0;i<result.count;i++)
        {
            count+=[result[i][0] integerValue];
        }
        queryfood = [[NSString alloc] initWithFormat:@"select calories from Dinner where datef='%@' and email='%@';",currentDate,email];
        result =[dbmanager loadDataFromDB:queryfood];
        
        for (int i=0;i<result.count;i++)
        {
            count+=[result[i][0] integerValue];
        }
        
        queryfood = [[NSString alloc] initWithFormat:@"select calories from Snack where datef='%@' and email='%@';",currentDate,email];
        result =[dbmanager loadDataFromDB:queryfood];
        
        for (int i=0;i<result.count;i++)
        {
            count+=[result[i][0] integerValue];
        }
        NSString *queryExe = [[NSString alloc] initWithFormat:@"select calories from Exercise where datef='%@'and email='%@';",currentDate,email];
        NSArray * result1 =[dbmanager loadDataFromDB:queryExe];
        int countex=0;
        for (int i=0;i<result1.count;i++)
        {
            countex+=[result1[i][0] integerValue];
        }
        float i=(count-countex);
        float j,k,q;
        j=calperday+(calperday*.5);
        k=(calperday+(calperday*.75));
        q=( calperday+(calperday*1));
        if(i <calperday)
        {
            NSLog(@"1");
            [color addObject:[[UIColor alloc ] initWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f] ];
        }
        else if(i>calperday && i<j)
            {
                NSLog(@"3");
                [color addObject:[[UIColor alloc ] initWithRed:83.0f/255.0f green:217.0f/255.0f blue:58.0f/255.0f alpha:1.0f] ];
                
            }
        else if(i>j && i< k)
            {
                
                [color addObject:[[UIColor alloc ] initWithRed:0.550 green:0.550 blue:0.557 alpha:1.000] ];
            }
        
        else if(  i>k &&i<q )
            {
                NSLog(@"2");
                    [color addObject:[UIColor orangeColor]];
            }
        
        
        else
                    
            {
                  [color addObject:[UIColor redColor]];
                    
            }
   }
    
}
-(void) datachange
{
    
    
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSArray *date=[[NSString stringWithFormat:@"%@",[df stringFromDate:Date.date]] componentsSeparatedByString:@""];
  
    NSString * currentDate=[date objectAtIndex:0];
    NSString * month=[currentDate substringFromIndex:5 ];
    NSString *year =[currentDate substringFromIndex:0];
    year =[year substringToIndex:4];
    month =[month substringToIndex:2];


    if([month isEqualToString:@"01" ]||[month isEqualToString:@"03" ] ||[month isEqualToString:@"05" ] || [month isEqualToString:@"07" ] ||[month isEqualToString:@"08" ] ||[month isEqualToString:@"10" ] ||[month isEqualToString:@"12" ] )
    { calenderdate =[[NSArray alloc] initWithObjects:
                   @"1",@"2",@"3",@"4",@"5",@"6",@"7",
                   @"8",@"9",@"10",@"11",@"12",@"13",@"14",
                   @"15",@"16",@"17",@"18",@"19",@"20",@"21",
                   @"22",@"23",@"24",@"25",@"26",@"27",@"28",
                   @"29",@"30",@"31",
                   nil];
  
       color=[[NSMutableArray alloc] init];
        [self getcolor:month  :year :31 :color];
    
        
 
        _canlender.frame =CGRectMake(32,132,362,255);
    }
    else if([month isEqualToString:@"04" ]||[month isEqualToString:@"06" ] ||[month isEqualToString:@"09" ] || [month isEqualToString:@"11" ]  )
  
    {

        
        calenderdate =[[NSArray alloc] initWithObjects:
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",
                       @"8",@"9",@"10",@"11",@"12",@"13",@"14",
                       @"15",@"16",@"17",@"18",@"19",@"20",@"21",
                       @"22",@"23",@"24",@"25",@"26",@"27",@"28",
                       @"29",@"30",
                       nil];
        
   color=[[NSMutableArray alloc] init];
        [self getcolor:month  :year :30 :color];
    
_canlender.frame =CGRectMake(32,132,362,255);
    }
    else
    {
    
        int yearint =[year intValue];
        if(yearint %4 ==0)
        {
            calenderdate =[[NSArray alloc] initWithObjects:
                           @"1",@"2",@"3",@"4",@"5",@"6",@"7",
                           @"8",@"9",@"10",@"11",@"12",@"13",@"14",
                           @"15",@"16",@"17",@"18",@"19",@"20",@"21",
                           @"22",@"23",@"24",@"25",@"26",@"27",@"28",
                           @"29",
                           nil];
            
   color=[[NSMutableArray alloc] init];
            [self getcolor:month  :year :29 :color];
            _canlender.frame =CGRectMake(32,132,362,255);
        }
        else
        {
            calenderdate =[[NSArray alloc] initWithObjects:
                           @"1",@"2",@"3",@"4",@"5",@"6",@"7",
                           @"8",@"9",@"10",@"11",@"12",@"13",@"14",
                           @"15",@"16",@"17",@"18",@"19",@"20",@"21",
                           @"22",@"23",@"24",@"25",@"26",@"27",@"28",
                           nil];
            
     color=[[NSMutableArray alloc] init];
            [self getcolor:month  :year :28 :color];
            _canlender.frame =CGRectMake(32,132,362,210);
        }
        
        
    }
    [_canlender reloadData];
}




-(IBAction)datechnage:(id)sender
{ [self datachange];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    email=[user objectForKey:@"email"];
    
  dbmanager=[MainScreen Connection];

    [_canlender registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _canlender.layer.borderWidth=10.0f;
   _canlender.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor blackColor]);
    
   NSArray * q= [dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select Weight from userInfo where email='%@';",email]];
    _weight.text=q[0][0];
    [self datachange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
