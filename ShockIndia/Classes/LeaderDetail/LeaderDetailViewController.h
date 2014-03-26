//
//  LeaderDetailViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Leaders;
@class WEPopoverController;


@interface LeaderDetailViewController : UIViewController<UIActionSheetDelegate>
{


    UIButton *buttonRef;
}
@property (strong, nonatomic) IBOutlet UILabel *lblLeaderName;
@property (strong, nonatomic) IBOutlet UIButton *btnShocks;
@property (strong, nonatomic) IBOutlet UIButton *btnComment;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (nonatomic, strong) WEPopoverController *popoverController;



@property (strong, nonatomic) IBOutlet UITextView *leaderDetailTextView;
- (IBAction)shockedBtnClicked:(id)sender;
- (IBAction)commentBtnClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *leaderIconImageView;
@property (strong,nonatomic) Leaders *leaderObj;
- (IBAction)shareOnSocialSite:(id)sender;

@end
