//
//  HomeViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 01/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//
#import "HomeViewController.h"
#import "Global.h"
#import "FactViewController.h"
#import "QuizViewController.h"
#import "OpinionViewController.h"
#import "ProfileViewController.h"
#import "WhyVoteViewController.h"
#import "SWRevealViewController.h"
#import "StoryViewController.h"
#import "PartyInfoViewController.h"
#import "PartyInfoController.h"
#import "AboutUsViewController.h"
#import "LeaderInfoController.h"
#import "Constants.h"
@interface HomeViewController ()
-(void)goToAboutUsView;
-(void)toChangeSplashBackgroundImage:(NSArray*)nsarry;
- (void)showSplash;
- (void)removeSplash;
@end

@implementation HomeViewController
@synthesize splashView = splashView_;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   
   
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"launch"]) {
        
        [self showSplash];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"launch"];
    }
    else
    {
        [[Global sharedController]addTopBar:self];
    }
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

}
- (void)showSplash
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
    webView.scalesPageToFit = TRUE;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource: @"splash" ofType: @"gif"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    [webView setUserInteractionEnabled:NO];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    self.splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
    self.splashView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
	[ self.splashView addSubview:webView];
    [self.view addSubview:self.splashView];
    
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:4];
    
}
-(void)goToAboutUsView
{
    AboutUsViewController *aboutUs =[[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
    [self.navigationController  pushViewController:aboutUs animated:YES];
    
    
}

- (void)removeSplash
{
    [self.splashView removeFromSuperview];
    [[Global sharedController]addTopBar:self];

    //[self loadAnimationView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)whyVotebtnTap:(UIButton *)sender
{
      WhyVoteViewController*viewController = [[WhyVoteViewController alloc]initWithNibName:@"WhyVoteViewController" bundle:Nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)factbtnTap:(UIButton *)sender
{
    FactViewController *viewController = [[FactViewController alloc]initWithNibName:@"FactViewController" bundle:Nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
- (IBAction)profilebtnTap:(UIButton *)sender
{
    
    if (IS_IPHONE_5) {
        ProfileViewController *viewController = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController1" bundle:Nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
    
        ProfileViewController *viewController = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:Nil];
        [self.navigationController pushViewController:viewController animated:YES];
    
    
    }
    
    
    
    
}
- (IBAction)quizbtnTap:(UIButton *)sender
{
    if (IS_IPHONE_5) {
        QuizViewController *viewController = [[QuizViewController alloc]initWithNibName:@"QuizViewController1" bundle:Nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
    
        QuizViewController *viewController = [[QuizViewController alloc]initWithNibName:@"QuizViewController" bundle:Nil];
        [self.navigationController pushViewController:viewController animated:YES];
    
    
    }
    
    
   
}
- (IBAction)pollbtnTap:(UIButton *)sender
{
    
if (![[NSUserDefaults standardUserDefaults]objectForKey:@"party_id"]) {
        PartyInfoController *partyInfoController = [[PartyInfoController alloc] initWithNibName:@"PartyInfoController" bundle:nil];
        [self.navigationController pushViewController:partyInfoController animated:YES];
    }
    else if (![[NSUserDefaults standardUserDefaults]objectForKey:@"leader_id"]) {
        LeaderInfoController *partyInfoController = [[LeaderInfoController alloc] initWithNibName:@"LeaderInfoController" bundle:nil];
        [self.navigationController pushViewController:partyInfoController animated:YES];
    }
    else
    {
        OpinionViewController *partyInfoController = [[OpinionViewController alloc] initWithNibName:@"OpinionViewController" bundle:nil];
        [self.navigationController pushViewController:partyInfoController animated:YES];
    }
    
 
}
-(void)loadAnimationView
{
    NSArray*  imageAr=[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil];
   
    [self performSelector:@selector(toChangeSplashBackgroundImage:) withObject:imageAr afterDelay:2];
}

-(void)toChangeSplashBackgroundImage:(NSArray*)nsarry
{
    if (imageIndex==[nsarry count])
        imageIndex=0;
    NSString* imageName=[nsarry objectAtIndex:imageIndex++];
    [UIView transitionWithView:self.view
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^
     {
         animateImageView.image = [UIImage imageNamed:imageName];
     }
                    completion:NULL];
    [self performSelector:@selector(toChangeSplashBackgroundImage:) withObject:nsarry afterDelay:3.0];
}

-(void)animatationDidStop
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toChangeSplashBackgroundImage) object:nil];
}

@end
