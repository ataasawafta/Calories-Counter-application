//
//  DInnerDisplay.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "DInnerDisplay.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface DInnerDisplay ()

@end

@implementation DInnerDisplay
{
    NSString *email;
    NSArray *Dinner;
    DBManager *dbmanager;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    dbmanager=[MainScreen  Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    Dinner =[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Dinner  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
    self.navigationController.title=@"Dinner";
}

-(void )DataChange{
    
        Dinner =[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Dinner  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * name=cell.textLabel.text;
    
    UIAlertController * selectedcell=[UIAlertController alertControllerWithTitle:name message:[[NSString alloc]initWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
    
    [selectedcell addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSArray *r=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Dinner where foodName='%@' and email='%@'and datef='%@'",name,email,[MainScreen currentDate]]];
        textField.placeholder = r[0][2];
    }];
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              
                              if(![selectedcell.textFields[0].text isEqualToString:@""])
                              {
                                  float data=selectedcell.textFields[0].text.floatValue;
                                  NSArray *Data=[dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select * from Dinnerlist where name='%@';",name ]];
                                  float w =[Data[0][1] floatValue ];
                                  float cal =[Data[0][2]  floatValue];
                                  float   c=(data*cal)/w;
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Dinner set calories='%f'where  foodName='%@' and email='%@' and datef='%@'",c,name,email,[MainScreen currentDate]]];
                              }
                              [self DataChange];
                              [_tableView reloadData];
                              
                          }
                          ];
    
    UIAlertAction *Delete =[ UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"Delete from Dinner where  foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];                                
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
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    UIViewController * toDinner =[self.storyboard  instantiateViewControllerWithIdentifier :@"navDinner"];
    [self presentViewController:toDinner animated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return Dinner.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString * tabledef=@"dinner";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[Dinner[indexPath.row]  objectAtIndex:1];
    cell.detailTextLabel.text=[Dinner[indexPath.row]  objectAtIndex:2];
      cell.textLabel.textColor=[UIColor blackColor];
 cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;


}
@end
