//
//  StoryViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WEPopoverController;
@interface StoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UIButton *buttonRef;

}


- (IBAction)submitNewStory:(id)sender;
@property (strong, nonatomic)Story *storyObj;
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *storyTableView;
@property (nonatomic, strong) WEPopoverController *popoverController;
@end
