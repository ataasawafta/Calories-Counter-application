//
//  MenuOptions.m
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/14/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import "MenuOptions.h"

@interface MenuOptions ()
{NSArray *menuItem;
}
@end

@implementation MenuOptions

@synthesize  profileImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
   NSString * email=[user objectForKey:@"email"];
    _name.text=[user objectForKey:@"name"];
    menuItem =[[NSArray alloc] initWithObjects:@"image",@"Home",@"Profile",@"Report",@"LogOut", nil];
profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    profileImage.layer.masksToBounds=true;
    
}
-(IBAction)logOut:(id)sender
{
 NSUserDefaults *defualt=[NSUserDefaults standardUserDefaults];
    [defualt removeObjectForKey:@"email"];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [menuItem count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==4)
    {

        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"email"];
        
        UIViewController * tologin =[self.storyboard  instantiateViewControllerWithIdentifier:@"FirstScreen"];
     [self presentViewController:tologin animated:YES completion:nil];
        
    }

    
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Menu" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
