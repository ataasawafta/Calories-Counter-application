//
//  DinnerList.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "DinnerList.h"
#import "DBManager.h"
#import "MainScreen.h"
@interface DinnerList ()

@end

@implementation DinnerList
{
    NSString *email;
    NSArray *dinnername;

    DBManager *dbmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.title=@"Dinner";
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    
     dbmanager=[MainScreen Connection];
    
    [self allFood];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender
{
    UIViewController * toFood =[self.storyboard  instantiateViewControllerWithIdentifier :@"NavFood"];
    [self presentViewController:toFood animated:YES completion:nil];}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return dinnername.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * tabledef=@"dinnerlist";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[dinnername[indexPath.row]  objectAtIndex:0];
   cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;
}
-(void) allFood
{
    dinnername=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Dinnerlist ;"]]];
    

}

- (IBAction)buttonPressed:(id)sender
{
    if(self.control.selectedSegmentIndex==0)
    {
        [self allFood];
    }
    
    else
    {
        dinnername=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Dinnerfavoritelist where favorite=1 and email='%@';" ,email]]];
        
    }
    
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString* text=cell.textLabel.text;
    NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Dinnerlist where name='%@'",text]];
    int time =[rs[0][1] intValue];
    int  calories =[rs[0][2] intValue ];
    
    
    UIAlertController * AddDinner =[UIAlertController alertControllerWithTitle:@"Dinner" message:[[NSString alloc]initWithFormat:@"%@",text] preferredStyle:UIAlertControllerStyleAlert];
    
    [AddDinner addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              if(![AddDinner.textFields[0].text isEqualToString:@""])
                              {
                                  float cal = 0;
                                  float x= [AddDinner.textFields[0].text  floatValue];
                                  cal=(x*calories)/time;
                                
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert  into Dinner values ('%@','%@','%f','%@');",email,text,cal,[MainScreen currentDate]]];
                                  
                                  
                                  
                                  
                              }
                              
                              
                              [self allFood ];
                              [tableView reloadData];
                              
                              
                              
                          }];
    
    UIAlertAction *Favorite =[ UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into Dinnerfavoritelist values ('%@',1,'%@');",text,email]];
                                  
                              }];
    UIAlertAction *Cancel =[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                
                            }];
    
    [AddDinner addAction:Favorite];
    [AddDinner addAction:Save];
    [AddDinner addAction:Cancel];
    [self presentViewController:AddDinner animated:YES completion:nil];
    

    
}

-(IBAction)addDinner:(id)sender{
 
    
    UIAlertController * AddDinner =[UIAlertController alertControllerWithTitle:@"Dinner" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [AddDinner addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [AddDinner addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    [AddDinner addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Calories";
    }];
    
    
    
    UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             
                             
                             
                             
                             
                             
                             if( ![AddDinner.textFields[0].text isEqualToString:@""] &&![AddDinner.textFields[1].text isEqualToString:@""]&& ![AddDinner.textFields[2].text  isEqualToString:@""])
                                 
                             {
                                 
                                 NSArray * rs=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from Dinnerlist where name='%@';",AddDinner.textFields[0].text]];
                                 if(rs.count==0)
                                 {
                                     [dbmanager executeQuery:[[NSString alloc ]initWithFormat:@"insert into Dinnerlist values ('%@','%f','%f');",AddDinner.textFields[0].text ,AddDinner.textFields[1].text.floatValue,AddDinner.textFields[2].text.floatValue]];
                                     
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
    
    [AddDinner addAction:Add];
    [AddDinner addAction:Cancel];
    [self presentViewController:AddDinner animated:YES completion:nil];
    
    
    
    
}

@end
