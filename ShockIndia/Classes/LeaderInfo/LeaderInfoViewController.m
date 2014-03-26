//
//  LeaderInfoViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "LeaderInfoViewController.h"
#import "SWRevealViewController.h"
#import "LeaderDetailViewController.h"
#import "LeaderCell.h"
#import "Leaders.h"
#import "Constants.h"
#import "ContentViewController.h"
@interface LeaderInfoViewController ()

@end

@implementation LeaderInfoViewController
@synthesize dataSource = dataSource_;

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
    [[Global sharedController]addTopBar:self];
    self.dataSource = [[[DataBaseController sharedController]getLeadersData]mutableCopy];
    [leaderTableView reloadData];
 
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count]/2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier =@"identifier";
    
    LeaderCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
  
    
    if(cell == nil)
    {
        NSBundle *bundle =[NSBundle mainBundle];
        
        NSArray *array =[bundle loadNibNamed:@"LeaderCell" owner:self options:nil];
        
        
        cell =[array objectAtIndex:0];
        
        
    }
    short index = indexPath.row*2;
    if ([self.dataSource count]>index) {
        Leaders *obj = [self.dataSource objectAtIndex:index];
        cell.party1_label.text = obj.leaders_name;
        [cell.party1_image setImageWithURL:[NSURL URLWithString:obj.leaders_icon] placeholderImage:nil];
        cell.party1_image.layer.borderColor = UIColorFromRGB(0x6cab36).CGColor;
        cell.party1_image.layer.borderWidth = 2;
        cell.btn.tag=index;
        
        [cell.btn  addTarget:self action:@selector(buttonTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        cell.btn.hidden = TRUE;
        cell.party1_image.hidden = TRUE;
        cell.party1_label.hidden = TRUE;
    }
    if ([self.dataSource count]>index+1) {
        Leaders *obj1 = [self.dataSource objectAtIndex:index+1];
        cell.btn1.tag=index+1;
        cell.party2_label.text = obj1.leaders_name;
        [cell.party2_image setImageWithURL:[NSURL URLWithString:obj1.leaders_icon] placeholderImage:nil];
        cell.party2_image.layer.borderColor = UIColorFromRGB(0x6cab36).CGColor;
        cell.party2_image.layer.borderWidth = 2;
        [cell.btn1  addTarget:self action:@selector(buttonTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        cell.btn1.hidden = TRUE;
        cell.party2_image.hidden = TRUE;
        cell.party2_label.hidden = TRUE;
        
    }

    
    return cell;
    
    
    
    
}
- (void)buttonTappedOnCell:(UIButton *)button
{
    if (IS_IPHONE_5) {
        ContentViewController *content=[[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
        [content.view setHidden:YES];
        
        LeaderDetailViewController *leaderDetail =[[LeaderDetailViewController alloc]initWithNibName:@"LeaderDetailViewController" bundle:nil];
        leaderDetail.leaderObj = [self.dataSource objectAtIndex:button.tag];
        [self.navigationController pushViewController:leaderDetail animated:YES];
        
    }
    else{
    
        LeaderDetailViewController *leaderDetail =[[LeaderDetailViewController alloc]initWithNibName:@"LeaderDetailViewController1" bundle:nil];
        leaderDetail.leaderObj = [self.dataSource objectAtIndex:button.tag];
        [self.navigationController pushViewController:leaderDetail animated:YES];
     
    
    }
    

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
