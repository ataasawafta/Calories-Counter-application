//
//  BreakFastList.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "BreakFastList.h"
#import "DBManager.h"
#import "MainScreen.h"
@interface BreakFastList ()

@end

@implementation BreakFastList

{
    NSString *email;
    NSArray *breakfastname;

    DBManager *dbmanager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    dbmanager =[MainScreen Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    [self allFood];
self.navigationController.title=@"Breakfast"; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender{
    UIViewController * toFood =[self.storyboard  instantiateViewControllerWithIdentifier :@"NavFood"];
    [self presentViewController:toFood animated:YES completion:nil];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return breakfastname.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * tabledef=@"breakfastlist";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[breakfastname[indexPath.row]  objectAtIndex:0];
 
    cell.textLabel.textColor=[UIColor blackColor];
  
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;
}
-(void) allFood{
    
    breakfastname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from Breakfastlist;"]]];
    
 
}
- (IBAction)buttonPressed:(id)sender
{
if(self.control.selectedSegmentIndex==0)
{
    [self allFood];
}
    
else
    {
        
        breakfastname=[[NSArray alloc] initWithArray:[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select name from breakfastfavoritelist where favorite=1 and email='%@';" ,email]]];
        
    }
    
    
    [self.tableView reloadData];
    }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString* text=cell.textLabel.text;
    NSArray *rs=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from breakfastlist where name='%@'",text]];
    int time =(int )rs[0][1];
    int  calories =(int)rs[0][2];
    
    
    UIAlertController * AddLunch =[UIAlertController alertControllerWithTitle:@"BreakFast" message:[[NSString alloc]initWithFormat:@"%@",text] preferredStyle:UIAlertControllerStyleAlert];
    
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
                                  
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert  into Breakfast values ('%@','%@','%f','%@');",email,text,cal,[MainScreen currentDate]]];
                                  
                                  
                              }
                              
                              
                              
                              [self allFood];
                              [tableView reloadData];
                              
                              
                          }];
    
    UIAlertAction *Favorite =[ UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"insert into breakfastfavoritelist values ('%@',1,'%@');",text,email]];
                                  
                              }];
    UIAlertAction *Cancel =[ UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                
                            }];
    
    [AddLunch addAction:Favorite];
    [AddLunch addAction:Save];
    [AddLunch addAction:Cancel];
    [self presentViewController:AddLunch animated:YES completion:nil];
    
    

    
    
}
-(IBAction)addBreakFast:(id)sender
{
    
    UIAlertController * AddBreakfast =[UIAlertController alertControllerWithTitle:@"Break Fast" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [AddBreakfast addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [AddBreakfast addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Weight";
    }];
    [AddBreakfast addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Calories";
    }];
    
    
    
    UIAlertAction *Add =[ UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             
                        
                             if( ![AddBreakfast.textFields[0].text isEqualToString:@""] &&![AddBreakfast.textFields[1].text isEqualToString:@""]&& ![AddBreakfast.textFields[2].text  isEqualToString:@""])
                                 
                             {
                                 
                                 NSArray * rs=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat:@"select * from breakfastlist where name='%@';",AddBreakfast.textFields[0].text]];
                                 if(rs.count==0)
                                 {
                                     [dbmanager executeQuery:[[NSString alloc ]initWithFormat:@"insert into breakfastlist values ('%@','%f','%f');",AddBreakfast.textFields[0].text ,AddBreakfast.textFields[1].text.floatValue,AddBreakfast.textFields[2].text.floatValue]];
                                    
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

    
    [AddBreakfast addAction:Add];
    [AddBreakfast addAction:Cancel];
    [self presentViewController:AddBreakfast animated:YES completion:nil];
    
}
@end
