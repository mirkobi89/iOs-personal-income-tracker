//
//  ReportsViewController.h
//  MiaApp
//
//  Created by Xcode on 26/09/14.
//  Copyright (c) 2014 mirko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController
                                    <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *dateBar;
@property NSDate* currentDate;
@property NSArray* tableViewArray;

-(IBAction)prec:(id)sender;
-(IBAction)succ:(id)sender;


@end
