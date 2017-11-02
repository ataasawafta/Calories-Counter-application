#import "SnackList.h"
#import "DBManager.h"
@interface SnackList ()

@end

@implementation SnackList
{
    NSString *email;
    NSArray *snackname;
   
    DBManager *dbmanager;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dbmanager=[MainScreen Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    
    [self allFood];
    self.navigationController.title=@"Snack";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    UIViewController * toFood =[self.storyboard  instantiateViewControllerWithIdentifier :@"NavFood"];
    [self presentViewController:toFood animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return snackname.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{static NSString * tabledef=@"snacklist";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[snackname[indexPath.row] objectAtIndex:0];
      cell.textLabel.textColor=[UIColor blackColor];
  cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}

-(void) allFood
{
    snackname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Snacklist ;"]]];
    

}

- (IBAction)buttonPressed:(id)sender
{
    if(self.control.selectedSegmentIndex==0)
    {
        [self allFood];
    }
    
    else
    {
        snackname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Snackfavoritelist where favorite=1 and email='%@';" ,email]]];
        
       
    }
    
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString* text=cell.textLabel.text;
    NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Snacklist where name='%@'",text]];
    int time =[rs[0][1] intValue];
    int  calories =[rs[0][2]intValue];
    
    
    UIAlertController * AddSnack =[UIAlertController alertControllerWithTitle:@"Snack" message:[[NSString alloc]initWithFormat:@"%@",text] preferredStyle:UIAlertControllerStyleAlert];
    
    [AddSnack addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                  if(![AddSnack.textFields[0].text isEqualToString:@""])
                              {
                                  float cal = 0;
                                  float x= [AddSnack.textFields[0].text  floatValue];
                                  cal=(x*calories)/time;
                            
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert  into Snack values ('%@','%@','%f','%@');",email,text,cal,[MainScreen currentDate]]];
                                  
                               
                              }
                              [self allFood];
                              [tableView reloadData];
                              
                              
                              
                              
                          }];
    
    UIAlertAction *Favorite =[ UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into Snackfavoritelist values ('%@',1,'%@');",text,email]];
                                  
                              }];
    UIAlertAction *Cancel =[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                
                            }];
    
    [AddSnack addAction:Favorite];
    [AddSnack addAction:Save];
    [AddSnack addAction:Cancel];
    [self presentViewController:AddSnack animated:YES completion:nil];
    
    
}

-(IBAction)addSnack:(id)sender
{

    
    UIAlertController * AddSnack =[UIAlertController alertControllerWithTitle:@"Snack" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [AddSnack addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [AddSnack addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    [AddSnack addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Calories";
    }];
    
    
    
    UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             
                             
                             if( ![AddSnack.textFields[0].text isEqualToString:@""] &&![AddSnack.textFields[1].text isEqualToString:@""]&& ![AddSnack.textFields[2].text  isEqualToString:@""])
                                 
                             {
                                 
                                 NSArray * rs=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Snacklist where name='%@';",AddSnack.textFields[0].text]];
                                 if(rs.count==0)
                                 {
                                     [dbmanager executeQuery:[[NSString alloc ]initWithFormat:@"insert into Snacklist values ('%@','%f','%f');",AddSnack.textFields[0].text ,AddSnack.textFields[1].text.floatValue,AddSnack.textFields[2].text.floatValue]];
                                     
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
    
    [AddSnack addAction:Add];
    [AddSnack addAction:Cancel];
    [self presentViewController:AddSnack animated:YES completion:nil];

 [_tableView reloadData];
}



@end
