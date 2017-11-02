//
//  ExerciseDisplay.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "ExerciseDisplay.h"
#import "MainScreen.h"
#import "DBManager.h"
@interface ExerciseDisplay ()

@end

@implementation ExerciseDisplay
{
    NSString *email;
    NSArray * execrise;
    DBManager *dbmanager;
}
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dbmanager=[MainScreen  Connection];
    NSUserDefaults *defualt =[NSUserDefaults standardUserDefaults];
    email=[defualt objectForKey:@"email"];
    
     execrise=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Exercise  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];

self.navigationController.title=@"Exercise";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return execrise.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * tabledef=@"exe";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:tabledef];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tabledef ];
    }
    
    cell.textLabel.text=[execrise[indexPath.row]  objectAtIndex:1];
    cell.detailTextLabel.text=[execrise[indexPath.row]  objectAtIndex:2];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
    
    
}

-(IBAction)back:(id)sender
{
    UIViewController * toExerices =[self.storyboard  instantiateViewControllerWithIdentifier :@"navexce"];
    [self presentViewController:toExerices animated:YES completion:nil];
}
-(void )DataChange{
    
    
    
    execrise=[dbmanager loadDataFromDB:[[NSString alloc] initWithFormat: @"select *  from Exercise  where email='%@' and datef='%@';",email,[MainScreen currentDate]]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * name=cell.textLabel.text;
    
    UIAlertController * selectedcell=[UIAlertController alertControllerWithTitle:name message:[[NSString alloc]initWithFormat:@""] preferredStyle:UIAlertControllerStyleAlert];
    
    [selectedcell addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        NSArray *r=[dbmanager loadDataFromDB:[[NSString alloc]initWithFormat:@"select * from Exercise where execriseName='%@' and email='%@'and datef='%@'",name,email,[MainScreen currentDate]]];
        textField.placeholder = r[0][2];
    }];
    
    UIAlertAction *Save =[ UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              if(![selectedcell.textFields[0].text isEqualToString:@""])
                              {
                                  int data=selectedcell.textFields[0].text.intValue;
                              NSArray *Data=[dbmanager loadDataFromDB:[[NSString alloc ]initWithFormat:@"select * from Exerciselist where execriseName='%@';",name]];
                                  float time =[Data[0][1] floatValue ];
                                  float cal =[Data[0][2]  floatValue];
                              float    c=(data*cal)/time;
                                  [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"update Exercise  set calories='%f'where  execriseName='%@' and email='%@' and datef='%@';",c,name,email,[MainScreen currentDate]]];
                              }
                              [self DataChange];
                              [_tableView reloadData];
                          }
                          ];
    
    UIAlertAction *Delete =[ UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              
                              
                                [dbmanager executeQuery:[[NSString alloc] initWithFormat:@"Delete from Exercise where  execriseName='%@' and email='%@' and datef='%@'",name,email,[MainScreen currentDate]]];
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
