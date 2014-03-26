//
//  PartyDetailViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WEPopoverController;
@class Parties;
@interface PartyDetailViewController : UIViewController
{
    UIButton *buttonRef;

}
@property (strong, nonatomic) IBOutlet UIImageView *partiesIconImageView;
@property (strong, nonatomic) IBOutlet UITextView *partyDescriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *lblPartyname;
@property (strong,nonatomic) Parties *partiesObj;
@property (strong, nonatomic) IBOutlet UIButton *btnShocks;
@property (strong, nonatomic) IBOutlet UIButton *btnComment;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;

@property (nonatomic, strong) WEPopoverController *popoverController;
- (IBAction)shockedBtnClicked:(id)sender;
- (IBAction)commentBtnClicked:(id)sender;
- (IBAction)shareOnSocialSite:(id)sender;

@end
