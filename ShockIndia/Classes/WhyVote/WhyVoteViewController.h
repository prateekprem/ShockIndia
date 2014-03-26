//
//  WhyVoteViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoryViewController;
@interface WhyVoteViewController : UIViewController<UIWebViewDelegate>
{
    StoryViewController *storyView;
    IBOutlet UIWebView *webView;

}
@property (strong, nonatomic) IBOutlet UIView *spreadView;
@property (strong, nonatomic) IBOutlet UIButton *btnWhyVote;
@property (strong, nonatomic) IBOutlet UIButton *btnStory;
@property (strong, nonatomic) IBOutlet UIButton *btnSpreadVoice;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

- (IBAction)whyVote:(id)sender;
- (IBAction)story:(id)sender;
- (IBAction)spreadYourVoice:(id)sender;
- (IBAction)postOnFacebook:(id)sender;
- (IBAction)postOnTwitter:(id)sender;
- (IBAction)sendGmail:(id)sender;
- (IBAction)sendMessage:(id)sender;
@end
