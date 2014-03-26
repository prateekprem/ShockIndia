//
//  ContentViewController.m
//  ShockIndia
//
//  Created by NZT Solutions on 06/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "ContentViewController.h"
#import "HomeViewController.h"
#import "PartyInfoViewController.h"
#import "LeaderInfoViewController.h"
#import "CampaignController.h"
#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import "MediaLibraryController.h"
#import "QuizViewController.h"
#import "FactViewController.h"
#import "OpinionViewController.h"
#import "ProfileViewController.h"
#import "WhyVoteViewController.h"
#import "PartyInfoController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

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
    self.navigationController.navigationBar.hidden = TRUE;
        self.view.frame=CGRectMake(0, 0, 100, 568);
      [self.contentTableView setBackgroundColor:[UIColor blackColor]];
    self.contentTableView.separatorColor=[UIColor clearColor];

    self.contentTableView.dataSource=self;
    self.contentTableView.delegate=self;
    self.contentArray =[NSArray arrayWithObjects:@"Home",@"Parties Info",@"Leaders Info",@"Fact",@"Quiz",@"Opinion Poll",@"My Profile",@"Why Vote",@"About Us", nil];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor blackColor]];
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor orangeColor];
        [cell setSelectedBackgroundView:view];
    }
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(5, 6, 20, 20)];
    im.contentMode = UIViewContentModeCenter;
    im.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:im];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(25, 6, cell.frame.size.width-40, cell.frame.size.height/2)];
   
    label.text=[self.contentArray objectAtIndex:indexPath.row];
    label.textColor =[UIColor whiteColor];
    label.shadowColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0, 1);
    
    label.font=[UIFont boldSystemFontOfSize:12.0];

    
    [cell.contentView addSubview:label];
    
    if ([label.text isEqualToString:@"Home"]) {
        im.image = [UIImage imageNamed:@"icon-home.png"];
    }
    else if ([label.text isEqualToString:@"Parties Info"]) {
        im.image = [UIImage imageNamed:@"icon-partyinfo.png"];

    }
    else if ([label.text isEqualToString:@"Leaders Info"]) {
        im.image = [UIImage imageNamed:@"leaders.png"];

    }
    else if ([label.text isEqualToString:@"Fact"]) {
        im.image = [UIImage imageNamed:@"fact_icon.png"];


    }
    else if ([label.text isEqualToString:@"Quiz"]) {
        im.image = [UIImage imageNamed:@"quiz.png"];

    }
    else if ([label.text isEqualToString:@"Opinion Poll"]) {
        im.image = [UIImage imageNamed:@"poll.png"];
        
    }
    else if ([label.text isEqualToString:@"My Profile"]) {
        im.image = [UIImage imageNamed:@"profile_icon.png"];
        
    }
    else if ([label.text isEqualToString:@"Why Vote"]) {
        im.image = [UIImage imageNamed:@"whyvote.png"];
        
    }
    else if ([label.text isEqualToString:@"About Us"]) {
       im.image = [UIImage imageNamed:@"icon-aboutus.png"];
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    SWRevealViewController *revealController = self.revealViewController;
    
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;      NSInteger row = indexPath.row;
    
	
	if (row == 0)
	{
        if (IS_IPHONE_5) {
            homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController1" bundle:nil];
        }
        else{
            homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        }

        if ( ![frontNavigationController.topViewController isKindOfClass:[HomeViewController class]] )
        {
       UINavigationController *navigationController =[[UINavigationController alloc]initWithRootViewController:homeView];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    
	else if (row == 1)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[PartyInfoViewController class]] )
        {
			PartyInfoViewController *partyInfoViewController = [[PartyInfoViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:partyInfoViewController];
			[revealController setFrontViewController:navigationController animated:YES];
            
		}
        
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row == 2)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[LeaderInfoViewController class]] )
        {
			LeaderInfoViewController *leaderInfoViewController = [[LeaderInfoViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leaderInfoViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row==3)
{
        if ( ![frontNavigationController.topViewController isKindOfClass:[FactViewController class]] )
       {
           FactViewController *factViewController = [[FactViewController alloc] initWithNibName:@"FactViewController" bundle:nil];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:factViewController];
        [revealController setFrontViewController:navigationController animated:YES];
           
		}
    
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row == 4)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[QuizViewController class]] )
        {
			QuizViewController *quizViewController = [[QuizViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:quizViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
    
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row == 5)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[OpinionViewController class]] )
        {
			PartyInfoController *partyController = [[PartyInfoController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:partyController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		
		else
		{
		[revealController rightRevealToggle:self];
		}
	}
    else if (row == 6)
    {
        if (IS_IPHONE_5) {
         
             profileView=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController1" bundle:nil];
            
        }
        else
        {
         
            profileView=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
            
            
            
        }
	
        if ( ![frontNavigationController.topViewController isKindOfClass:[ProfileViewController class]] )
        {
			
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:profileView];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row == 7)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[WhyVoteViewController class]] )
        {
			WhyVoteViewController *whyVoteViewController = [[WhyVoteViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:whyVoteViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    else if (row == 8)
	{
        if ( ![frontNavigationController.topViewController isKindOfClass:[AboutUsViewController class]] )
        {
			AboutUsViewController *aboutUsViewController = [[AboutUsViewController alloc] init];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutUsViewController];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		
		else
		{
			[revealController rightRevealToggle:self];
		}
	}
    
	

    
	



}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
