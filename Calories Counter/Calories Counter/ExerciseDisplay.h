//
//  ExerciseDisplay.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"MainScreen.h"
#import "DBManager.h"
@interface ExerciseDisplay : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain,nonatomic)    IBOutlet UITableView *table;
-(IBAction)back:(id)sender;

@property (retain ,nonatomic) IBOutlet UITableView * tableView;




@end
