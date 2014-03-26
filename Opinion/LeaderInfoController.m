//
//  LeaderInfoController.m
//  ShockIndia
//
//  Created by NZT Solutions on 12/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "LeaderInfoController.h"
#import "LeaderCell.h"
#import "Leaders.h"
#import "OpinionViewController.h"
#import "AnimateViews.h"

@interface LeaderInfoController ()

@end

@implementation LeaderInfoController

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
    [self.leaderTableVew reloadData];
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
       // cell.btn.tag=index;
        cell.btn1.tag=obj.leaders_id;
       
        
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
        //cell.btn1.tag=index+1;
        cell.btn1.tag=obj1.leaders_id;
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
- (void)buttonTappedOnCell:(UIButton*)button
{
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"stamp-normal.png"]];
    image.frame = CGRectMake(button.frame.size.width-40, button.frame.origin.y-10,45 , 45);
    [button addSubview:image];
    [[AnimateViews allocate] startAnimationOnview:image toView:nil animationType:BounceViewRevertAnimationType animationSubType:0];
 
    [self performSelector:@selector(callLeaderInfo) withObject:nil afterDelay:0.8];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",(long)button.tag] forKey:@"leader_id"];
    [[NSUserDefaults standardUserDefaults]synchronize];

  
}
- (void)callLeaderInfo
{
    OpinionViewController *opinionView =[[OpinionViewController alloc]initWithNibName:@"OpinionViewController" bundle:nil];
    [opinionView setLeaderid:i];
    [self.navigationController pushViewController:opinionView animated:YES];

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
