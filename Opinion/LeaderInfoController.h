//
//  LeaderInfoController.h
//  ShockIndia
//
//  Created by NZT Solutions on 12/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderInfoController : UIViewController
{

 NSInteger i;
}
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) IBOutlet UITableView *leaderTableVew;
@end
