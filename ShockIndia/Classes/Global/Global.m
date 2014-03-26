//
//  Global.m
//  MrsDash
//
//  Created by Kiwitech on 28/01/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//
#import <iAd/iAd.h>

#import "Global.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "FactViewController.h"
#import "OpinionViewController.h"
#import "QuizViewController.h"
#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "WhyVoteViewController.h"
#import "SignUpViewController.h"
#import "PartyInfoViewController.h"
#import "LeaderInfoViewController.h"
#import "PartyDetailViewController.h"
#import "LeaderDetailViewController.h"
#import "CampaignController.h"
#import "AboutUsViewController.h"
#import "DiscussionViewController.h"
#import "TermAndConditionController.h"
#import "PartyInfoController.h"
#import "LeaderInfoController.h"
#import "LeaderDetailViewController.h"
#import "PartyDetailViewController.h"
@implementation Global
@synthesize viewController = viewController_;
@synthesize bannerIsVisible = bannerIsVisible_;
static Global* _global;

+ (Global*)sharedController
{
	@synchronized(self)
    {
        if (_global == nil)
        {
            _global=[[self alloc] init];
        }
    }
      return _global;
}

#pragma mark - iAdBanner Delegates

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error in Loading Banner!");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"iAd banner Loaded Successfully!");
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"iAd Banner will load!");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"iAd Banner did finish");
    
}
-(void)goToAboutUsView
{
    AboutUsViewController *aboutUs =[[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.viewController.navigationController  pushViewController:aboutUs animated:YES];
    
    
}
- (void)addTopBar:(UIViewController *)viewController
{
    self.viewController = viewController;
   
    viewController.navigationController.navigationBar.hidden = FALSE;
    viewController.canDisplayBannerAds = YES;
    adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    adView.frame = CGRectOffset(adView.frame, 0, -adView.frame.size.height);
    [viewController.view addSubview:adView];
    adView.delegate= (id)self;
    self.bannerIsVisible=NO;
    
    SWRevealViewController * revealView =viewController.revealViewController;
    viewController.title=@"Shock India";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-menu.png"] style:UIBarButtonItemStylePlain target:revealView action:@selector(rightRevealToggle:)];
    viewController.navigationItem.rightBarButtonItem=rightBarButton;
   
   UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goToAboutUsView)];
   
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
    [viewController.view addGestureRecognizer:viewController.revealViewController.panGestureRecognizer];
    if ([viewController isKindOfClass:[TermAndConditionController class]])
    {
        
        viewController.navigationItem.rightBarButtonItem = nil;
        viewController.title = @"Terms of Service";
        
    }
    else if ([viewController isKindOfClass:[HomeViewController class]])
    {
       
        viewController.navigationItem.leftBarButtonItem = infoButton;
        viewController.title = @"Home";
        
    }
    else if ([viewController isKindOfClass:[ProfileViewController class]])
    {
        
        viewController.navigationItem.leftBarButtonItem = infoButton;

        viewController.title = @"My Profile";
        
    }
    else if ([viewController isKindOfClass:[OpinionViewController class]])
    {
        viewController.navigationItem.leftBarButtonItem = infoButton;

        viewController.title = @"Opinion Poll";
        
    }
    else if ([viewController isKindOfClass:[FactViewController class]])
    {
        

        viewController.title = @"Interesting Facts";
        
    }
    else if ([viewController isKindOfClass:[QuizViewController class]])
    {
        

        viewController.title= @"Quiz";
        
    }
    else if ([viewController isKindOfClass:[WhyVoteViewController class]])
    {
        

        viewController.title = @"Why Vote?";
        
    }
   
    else if  ([viewController isKindOfClass:[PartyInfoViewController class]])
    {
        viewController.navigationItem.leftBarButtonItem = infoButton;

        viewController.title = @"Party Information";
        
    }
    else if  ([viewController isKindOfClass:[LeaderInfoViewController class]])
    {
        viewController.navigationItem.leftBarButtonItem = infoButton;

        viewController.title = @"Leader Information";
        
    }
    else if  ([viewController isKindOfClass:[PartyDetailViewController class]])
    {
        
        viewController.title = @"Party Detail";
        
    }
    else if  ([viewController isKindOfClass:[LeaderDetailViewController class]])
    {
        viewController.title = @"Leader Detail";
        
    }
    else if  ([viewController isKindOfClass:[CampaignController class]])
    {

        viewController.title = @"Campaigns";
        
    }
    else if  ([viewController isKindOfClass:[AboutUsViewController class]])
    {
        viewController.navigationItem.leftBarButtonItem = backButton;
       // viewController.navigationItem.leftBarButtonItem.enabled = FALSE;
        viewController.title = @"About Us";
        
    }
    else if  ([viewController isKindOfClass:[DiscussionViewController class]])
    {

        viewController.title = @"Discussion Room";
        
    }
    else if  ([viewController isKindOfClass:[PartyInfoController class]])
    {
        viewController.navigationItem.leftBarButtonItem = infoButton;

        viewController.title = @"Opinion Poll";

    }
    else if  ([viewController isKindOfClass:[LeaderInfoController class]])
    {        viewController.navigationItem.leftBarButtonItem = infoButton;


        viewController.title = @"Opinion Poll";
        
    }
    else if  ([viewController isKindOfClass:[LeaderDetailViewController class]])
    {
        viewController.title = @"Leader Detail";
        
    }
    else if  ([viewController isKindOfClass:[PartyDetailViewController class]])
    {
        viewController.title = @"Party Detail";
        
    }





}


#pragma mark -
#pragma mark User Define Method
-(void)goToDiscussinView
{
    DiscussionViewController *discussion =[[DiscussionViewController alloc]initWithNibName:@"DiscussionViewController" bundle:nil];
    [self.viewController.navigationController  pushViewController:discussion animated:YES];

}
//-(void)goToAboutUsView
//{
//    AboutUsViewController *aboutUs =[[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
//[self.viewController.navigationController  pushViewController:aboutUs animated:YES];
//    
//    
//}

- (void)backPressed:(id)sender
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}
- (void)turnOnAdd:(BOOL)yes forViewController:(UIViewController *)vwController
{
    self.viewController.canDisplayBannerAds = YES;
}
@end
