//
//  MainScreen.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/17/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface MainScreen : UITableViewController
@property (retain ,nonatomic ) IBOutlet UIBarButtonItem *Menu;
@property (retain ,nonatomic) IBOutlet UIView * table;
@property (retain ,nonatomic )IBOutlet UITableViewCell *Food;
@property (retain ,nonatomic) IBOutlet UIDatePicker * date1;
@property(retain ,nonatomic) IBOutlet UITableViewCell *Execries;
@property(retain ,nonatomic) IBOutlet UITableViewCell *Water;
@property (retain ,nonatomic )IBOutlet UIProgressView *verygood;
@property (retain ,nonatomic )IBOutlet UIProgressView *good;
@property (retain ,nonatomic )IBOutlet UIProgressView *bad;
@property (retain ,nonatomic )IBOutlet UIProgressView *w;

@property (retain ,nonatomic) IBOutlet UILabel * caloriesperDay;
@property (retain,nonatomic) IBOutlet UILabel * remainingCalories;
-(IBAction)datechange:(id)sender;
+(NSDate *)  currentDate;
+(DBManager *) Connection;

@end
