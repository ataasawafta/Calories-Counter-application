//
//  LunchDispaly.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "LunchDispaly.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface LunchDispaly ()

@end

@implementation LunchDispaly
{
    NSString *email;
    NSArray *lunch;
    DBManager *dbmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dbmanager=[MainScreen  Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    lunch=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Lunch  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
     self.navigationController.title=@"Lunch";    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    UIViewController * tolunchlist =[self.storyboard  instantiateViewControllerWithIdentifier :@"navLunch"];
    [self presentViewController:tolunchlist animated:YES completion:nil];
}
-(void)DataChange
{
    lunch=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Lunch  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
    self.navigationController.title=@"Lunch";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * name=cell.textLabel.text;
    
    UIAlertController * selectedcell=[UIAlertController alertControllerWithTitle:name message:[[NSString alloc]initWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
    
    [selectedcell addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSArray *r=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Lunch where foodName='%@' and email='%@'and datef='%@'",name,email,[MainScreen currentDate]]];
        textField.placeholder = r[0][2];
    }];
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              if(![selectedcell.textFields[0].text isEqualToString:@""])
                              {
                                  int data=selectedcell.textFields[0].text.intValue;
                                  NSArray *Data=[dbmanager loadDataFromDB:[[NSString alloc ] initWithFormat:@"select * from Lunchlist where name='%@';",name ]];
                                  int w =[Data[0][1] intValue ];
                                  int cal =[Data[0][2]  intValue];
                                  int    c=(data*cal)/w;
 [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Lunch  set calories='%d'where  foodName='%@' and email='%@' and datef='%@'",c,name,email,[MainScreen currentDate]]];
                              }
                          
                              [self DataChange];
                              [_tableView reloadData];
                          
                          }
                          
                          ];
    
    UIAlertAction *Delete =[ UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                    [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"Delete from Lunch where  foodName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];
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





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return lunch.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString * tabledef=@"lunch";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[lunch[indexPath.row]  objectAtIndex:1];
    cell.detailTextLabel.text=[lunch[indexPath.row]  objectAtIndex:2];
      cell.textLabel.textColor=[UIColor blackColor];    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    return cell;



}




@end
