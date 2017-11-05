#import "Exercise.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface Exercise ()

@end

@implementation Exercise
{
    
    NSString * email;
    DBManager*dbmanager;
    NSArray  * ExerciseName;
  
}
@synthesize back;

-(IBAction)back:(id)sender
{
    
    UIViewController * to_Main =[self.storyboard  instantiateViewControllerWithIdentifier :@"ToMain"];
    [self presentViewController:to_Main animated:YES completion:nil];}

- (void)viewDidLoad {
    [super viewDidLoad];
    dbmanager =[MainScreen Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
   email=[defualt objectForKey:@"email"];
    [self allExercise];
    
    self.navigationController.title=@"Exercise";    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) allExercise
{
    
    ExerciseName=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select ExerciseName from Exerciselist;"]]];
  
    
    
}
- (IBAction)buttonPressed:(id)sender
{
    
    
   if(self.exercisecontrol.selectedSegmentIndex ==0)
   {
       
       [self allExercise];
       [self.tableView reloadData];
   }
    
else if(self.exercisecontrol.selectedSegmentIndex ==1)
{

    
    ExerciseName=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Exercisefavoritelist where favorite=1 and email='%@';" ,email]]];

    
[self.tableView reloadData];
}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * tabledef=@"exercieslist";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabledef];
    
    
    }
   
   
    
   cell.textLabel.text=[ExerciseName[indexPath.row] objectAtIndex:0];
    cell.textLabel.textColor=[UIColor blackColor];
     cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    
    return  ExerciseName.count;
    
    
}

-(IBAction)addnewExercise:(id)sender{


    UIAlertController * AddExE =[UIAlertController alertControllerWithTitle:@"Exercise" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [AddExE addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [AddExE addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Time";
    }];
    [AddExE addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Calories";
    }];
    
 
    
UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                     {
                      
                         
                         
                             if( ![AddExE.textFields[0].text isEqualToString:@""] &&![AddExE.textFields[1].text isEqualToString:@""]&& ![AddExE.textFields[2].text  isEqualToString:@""])
                             
                             {

                                 NSArray * rs=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Exerciselist where ExerciseName='%@';",AddExE.textFields[0].text]];
                                 if(rs.count==0)
                                 {
                                  
                                     
                             [dbmanager executeQuery:[[NSString alloc ]initWithFormat:@"insert into Exerciselist values ('%@','%f','%f');",AddExE.textFields[0].text ,[AddExE.textFields[1].text  floatValue],[AddExE.textFields[2].text floatValue]]];
                             
                                }
                             
                                 [self allExercise];
                                 [_tableView reloadData];
                         }
                         
                     }
               
                     ];
    UIAlertAction *Cancel=[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                         {
                             
                         }
                         
                         
                           ];
    
    [AddExE addAction:Add];
    [AddExE addAction:Cancel];
    [self presentViewController:AddExE animated:YES completion:nil];
   [self.tableView reloadData];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
   NSString* text=cell.textLabel.text;
    NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Exerciselist where ExerciseName='%@'",text]];

    
      UIAlertController * AddExE =[UIAlertController alertControllerWithTitle:@"Exercise" message:[[NSString alloc]initWithFormat:@"%@",text] preferredStyle:UIAlertControllerStyleAlert];
    
    [AddExE addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Time";
    }];
    
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                        
                          if(![AddExE.textFields[0].text isEqualToString:@""])
                          {
                    
                    int time = [AddExE.textFields[0].text intValue];
                         
                           
                              float time1 =[rs[0][1] floatValue];
                              float cal =[rs[0][2]  floatValue];
                              float   c=(time*cal)/time1;
                                [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert  into Exercise values ('%@','%@','%f','%@');",email,text,
                                                         c,[MainScreen currentDate]]];
                              
                              
                             
                            
                          }
                            
                         
                         }];
    
    UIAlertAction *Favorite =[ UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into Exercisefavoritelist values ('%@',1,'%@');",text,email]];
                              
                          }];
    UIAlertAction *Cancel =[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              
                          }];

    [AddExE addAction:Favorite];
    [AddExE addAction:Save];
    [AddExE addAction:Cancel];
    [self presentViewController:AddExE animated:YES completion:nil];
}
@end
