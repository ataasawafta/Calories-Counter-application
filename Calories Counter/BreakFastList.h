//
//  BreakFastList.h
//  Calories Counter
//
//  Created by Ataa Sawafta on 10/23/17.
//  Copyright © 2017 Ataa Sawafta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakFastList : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (retain ,nonatomic) IBOutlet UITableView *tableView;

@property (retain ,nonatomic ) IBOutlet UISegmentedControl *control;

-(IBAction)addBreakFast:(id)sender;
- (IBAction)buttonPressed:(id)sender;

-(IBAction)back:(id)sender;





@end
