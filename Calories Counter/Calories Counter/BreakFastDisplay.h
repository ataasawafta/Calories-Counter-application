//
//  BreakFastDisplay.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakFastDisplay : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain) IBOutlet UITableView *tableView;
-(IBAction)back:(id)sender;

@end
