//
//  BreakFastDisplay.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "BreakFastDisplay.h"
#import "DBManager.h"
#import "MainScreen.h"
@interface BreakFastDisplay ()

@end

@implementation BreakFastDisplay
{
    NSString *email;
    NSArray *breakfast;
   
    DBManager *dbmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    
    dbmanager=[MainScreen  Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    breakfast=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Breakfast  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
    self.navigationController.title=@"Breakfast";
}

-(void )DataChange{
       breakfast=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Breakfast  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * name=cell.textLabel.text;
    
    UIAlertController * selectedcell=[UIAlertController alertControllerWithTitle:name message:[[NSString alloc]initWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
    
    [selectedcell addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSArray *r=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Breakfast where foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];
        textField.placeholder = r[0][2];
    }];
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              if(![selectedcell.textFields[0].text isEqualToString:@""])
                              {
                                  float data=selectedcell.textFields[0].text.floatValue;
                                  NSArray *Data=[dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select * from  breakfastlist where name='%@';",name]];
                                  NSLog(@"%@",Data);
                                  float w =[Data[0][1] floatValue ];
                                  float cal =[Data[0][2]  floatValue];
                                  float    c=(data*cal)/w;
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Breakfast set calories='%f'where  foodName='%@' and email='%@' and datef='%@'",c,name,email,[MainScreen currentDate]]];
                              }
                              [self DataChange];
                              [_tableView reloadData];
                          }
                          ];
    
    UIAlertAction *Delete =[ UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                
                                [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"Delete from Breakfast where  foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];
                                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(IBAction)back:(id)sender
{
    UIViewController * tobreakfastlist =[self.storyboard  instantiateViewControllerWithIdentifier :@"navbreakFast"];
    [self presentViewController:tobreakfastlist animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return breakfast.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString * tabledef=@"breakfast";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[breakfast[indexPath.row]  objectAtIndex:1];
    cell.detailTextLabel.text=[breakfast[indexPath.row]  objectAtIndex:2];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;


}




@end
