//
//  SignUp1.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/12/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"


@interface SignUp1 : UITableViewController
@property (nonatomic ,retain) IBOutlet UIButton *male;
@property (nonatomic ,retain) IBOutlet UIButton *female;
@property (retain,nonatomic) IBOutlet UITextField *name;
@property (retain ,nonatomic ) IBOutlet UITextField * email;
@property (retain ,nonatomic) IBOutlet UIBarButtonItem * next;

+(NSString * )Name;
+(NSString *)Email;
+(NSData* ) BirthDay;
+(char)Gender;
+(NSString *) password;
@property(retain ,nonatomic) IBOutlet
UITextField *confirmemail;

@property (retain,nonatomic) IBOutlet
UITextField * confirmpassword;
@property (retain,nonatomic) IBOutlet
UITextField * password;

@property (retain ,nonatomic) IBOutlet UILabel * massage_name;
@property (retain ,nonatomic) IBOutlet UILabel *massage_email;

@property (retain,nonatomic ) IBOutlet UILabel * massage_confirm_email;@property (retain ,nonatomic)
IBOutlet UILabel *massage_password;
@property (retain ,nonatomic)
IBOutlet UILabel *massage_confirmpassword;
@property (retain ,nonatomic) IBOutlet UIDatePicker *BirthDay;
///////////

-(IBAction)male:(id)sender;
-(IBAction)female:(id)sender;
-(IBAction)Next:(id)sender;

@end
