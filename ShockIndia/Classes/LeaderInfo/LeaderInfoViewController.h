//
//  LeaderInfoViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderInfoViewController : UIViewController
{
    IBOutlet UITableView *leaderTableView;
}
@property (strong,nonatomic) NSMutableArray *dataSource;

@end
