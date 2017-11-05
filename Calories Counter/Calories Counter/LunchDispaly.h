//
//  LunchDispaly.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchDispaly : UIViewController<UITableViewDelegate, UITableViewDataSource>
-(IBAction)back:(id)sender;
@property (nonatomic,retain) IBOutlet UITableView *tableView;

/*** add action **/ 


@end
