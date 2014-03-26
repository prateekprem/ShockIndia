//
//  ContentViewController.h
//  ShockIndia
//
//  Created by NZT Solutions on 06/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
@class ProfileViewController;

@interface ContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    HomeViewController *homeView;
    ProfileViewController *profileView;
  
}
@property(strong,nonatomic)IBOutlet UITableView *contentTableView;
@property(strong ,nonatomic)NSArray *contentArray;

@end
