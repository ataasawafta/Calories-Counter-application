
#import "LunchList.h"
#import "DBManager.h"
#import "MainScreen.h"
@interface LunchList ()

@end

@implementation LunchList
{
    NSString *email;
    NSArray *lunchname;
 
    DBManager *dbmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dbmanager =[MainScreen Connection];
    self.navigationController.title=@"Lunch";
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
  
    [self allFood];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    UIViewController * toFood =[self.storyboard  instantiateViewControllerWithIdentifier :@"NavFood"];
    [self presentViewController:toFood animated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return lunchname.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ static NSString * tabledef=@"lunchlist";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[lunchname[indexPath.row]  objectAtIndex:0];
  ;
    
    cell.textLabel.textColor=[UIColor blackColor];
   cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}
-(void) allFood
{
    lunchname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Lunchlist;"]]];
    

}
- (IBAction)buttonPressed:(id)sender
{
    if(self.control.selectedSegmentIndex==0)
    {
        [self allFood];
    }
    
    else
    {
        
        
        lunchname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from lunchfavoritelist  where favorite=1 and email='%@';" ,email]]];
        
    
    }
    
    
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString* text=cell.textLabel.text;
    NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Lunchlist where name='%@'",text]];
    int time =(int )rs[0][1];
    int  calories =(int)rs[0][2];
    
    
    UIAlertController * AddLunch =[UIAlertController alertControllerWithTitle:@"Lunch" message:[[NSString alloc]initWithFormat:@"%@",text] preferredStyle:UIAlertControllerStyleAlert];
    
    [AddLunch addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              if(![AddLunch.textFields[0].text isEqualToString:@""])
                              {
                                  float cal = 0;
                                 float x= [AddLunch.textFields[0].text floatValue];
                                  cal=(x*calories)/time;
                                 
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert  into Lunch values ('%@','%@','%f','%@');",email,text,cal,[MainScreen currentDate]]];
                                  
                                
                              }
                              
                              [self allFood ];
                              [tableView reloadData];
                              
                              
                              
                              
                          }];
    
    UIAlertAction *Favorite =[ UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into Lunchfavoritelist values ('%@',1,'%@');",text,email]];
                                  
                              }];
    UIAlertAction *Cancel =[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                
                            }];
    
    [AddLunch addAction:Favorite];
    [AddLunch addAction:Save];
    [AddLunch addAction:Cancel];
    [self presentViewController:AddLunch animated:YES completion:nil];
    

    
}

-(IBAction)addLunch:(id)sender{
    
    UIAlertController * AddLunch =[UIAlertController alertControllerWithTitle:@"Lunch" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [AddLunch addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [AddLunch addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    [AddLunch addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Calories";
    }];
    
    
    
    UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             
                             
                             
                             
                             
                             
                             if( ![AddLunch.textFields[0].text isEqualToString:@""] &&![AddLunch.textFields[1].text isEqualToString:@""]&& ![AddLunch.textFields[2].text  isEqualToString:@""])
                                 
                             {
                                 
                                 NSArray * rs=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Lunchlist where name='%@';",AddLunch.textFields[0].text]];
                                 if(rs.count==0)
                                 {
                                     [dbmanager executeQuery:[[NSString alloc ]initWithFormat:@"insert into Lunchlist values ('%@','%f','%f');",AddLunch.textFields[0].text ,AddLunch.textFields[1].text.floatValue,AddLunch.textFields[2].text.floatValue]];
                                     
                                 }
                                 
                                 
                             }
                             
                             
                             
                             
                              [self allFood];                             
                            [_tableView reloadData];  
                             
                             
                         }
                         
                         
                         ];
    UIAlertAction *Cancel=[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                           {
                               
                           }
                           
                           
                           ];
    
    [AddLunch addAction:Add];
    [AddLunch addAction:Cancel];
    [self presentViewController:AddLunch animated:YES completion:nil];
    
    
}

@end
