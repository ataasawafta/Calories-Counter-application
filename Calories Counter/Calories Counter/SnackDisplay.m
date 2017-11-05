#import "SnackDisplay.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface SnackDisplay ()

@end

@implementation SnackDisplay
{
    NSString *email;
    NSArray *Snack;
    DBManager *dbmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dbmanager=[MainScreen  Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
   Snack=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Snack  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
    self.navigationController.title=@"Snack";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    
    UIViewController * toSnack =[self.storyboard  instantiateViewControllerWithIdentifier :@"navSnack"];
    [self presentViewController:toSnack animated:YES completion:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return Snack.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * tabledef=@"snack";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[Snack[indexPath.row] objectAtIndex:1];
    cell.detailTextLabel.text=[Snack [indexPath.row] objectAtIndex:2];
      cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}
-(void )DataChange{
    
    
       Snack=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Snack  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * name=cell.textLabel.text;
    UIAlertController * selectedcell=[UIAlertController alertControllerWithTitle:name message:[[NSString alloc]initWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
    
    [selectedcell addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSArray *r=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Snack where foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];
        textField.placeholder = r[0][2];
    }];
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              if(![selectedcell.textFields[0].text isEqualToString:@""])
                              {
                                  
                                  int data=selectedcell.textFields[0].text.intValue;
                                  NSArray *Data=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Snacklist where foodName='%@';",name]];
                                 float w =[Data[0][1] floatValue ];
                                  float cal =[Data[0][2]  floatValue];
                                  float    c=(data*cal)/w;                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Snack  set calories='%f'where  name='%@' and email='%@' and datef='%@'",c,name,email,[MainScreen currentDate]]];
                              }
                              
                              [self DataChange];
                              [_tableView reloadData];
                              
                          }
                          ];
    
    UIAlertAction *Delete =[ UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"Delete from Snack where  foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];                                
                                [self DataChange];
                                [_tableView reloadData];
                            }
                            ];
    UIAlertAction * Cancel=[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                            {
                            }
                            ];
    [selectedcell addAction:Save];
    [selectedcell addAction:Delete];
    [selectedcell addAction:Cancel];
    [self presentViewController:selectedcell animated:YES completion:nil];

}
@end
