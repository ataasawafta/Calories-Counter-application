//
//  Profile.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/15/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainScreen.h"
#import "DBManager.h"
@interface Profile : UITableViewController
@property (nonatomic ,retain) IBOutlet UIButton * profileImage;

@property (retain ,nonatomic ) IBOutlet UIBarButtonItem *back;
@property (retain ,nonatomic)  IBOutlet UIBarButtonItem *save;
@property (retain ,nonatomic) IBOutlet UIButton *male;
@property (retain ,nonatomic) IBOutlet UIButton *Female;
@property (retain ,nonatomic) IBOutlet UITextField * Name;
@property (retain ,nonatomic) IBOutlet UITextField * Email;
@property (retain ,nonatomic) IBOutlet UITextField * Password;
@property (retain ,nonatomic) IBOutlet UITextField * Weight;
@property (retain ,nonatomic) IBOutlet UITextField * Height;
@property (retain ,nonatomic) IBOutlet UITextField * TargetWeight;
@property (retain ,nonatomic) IBOutlet UITextField * Time;

@property (retain ,nonatomic) IBOutlet UIDatePicker *birthday;
-(IBAction)back:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)male:(id)sender;
-(IBAction)female:(id)sender;
-(IBAction)profileImage:(id)sender;


-(IBAction)Date:(id)sender;
@end
