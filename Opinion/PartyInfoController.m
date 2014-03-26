//
//  PartyInfoController.m
//  ShockIndia
//
//  Created by NZT Solutions on 12/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "PartyInfoController.h"
#import "PartyCell.h"
#import "Parties.h"
#import "LeaderInfoController.h"
#import "AnimateViews.h"
#import "OpinionViewController.h"
@interface PartyInfoController ()
- (void)callLeaderInfo;
@end

@implementation PartyInfoController

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
  
    
    self.dataSource=[[[DataBaseController sharedController]getPartiesData]mutableCopy];
    [self.partyTableView reloadData];
    NSLog(@"data source count %d",[self.dataSource count]);
   
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count]/2;
    NSLog(@"data source count is %d",[self.dataSource count]);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"row%ld",(long)indexPath.row];
    PartyCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        NSBundle *bundle =[NSBundle mainBundle];
        
        NSArray *array =[bundle loadNibNamed:@"PartyCell" owner:self options:nil];
        
        
        cell =[array objectAtIndex:0];
        
        
    }
    short index = indexPath.row*2;
    if ([self.dataSource count]>index) {
        Parties *obj = [self.dataSource objectAtIndex:index];
        cell.party1_label.text = obj.parties_short_name;
        [cell.party1_image setImageWithURL:[NSURL URLWithString:obj.parties_icon] placeholderImage:nil];
        cell.party1_image.layer.borderColor = UIColorFromRGB(0x6cab36).CGColor;
        cell.party1_image.layer.borderWidth = 2;
        cell.btn.tag=obj.parties_id;
      
        [cell.btn  addTarget:self action:@selector(buttonTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        cell.btn.hidden = TRUE;
        cell.party1_image.hidden = TRUE;
        cell.party1_label.hidden = TRUE;
    }
    if ([self.dataSource count]>index+1) {
        Parties *obj1 = [self.dataSource objectAtIndex:index+1];
        cell.btn1.tag= obj1.parties_id;
        cell.party2_label.text = obj1.parties_short_name;
        [cell.party2_image setImageWithURL:[NSURL URLWithString:obj1.parties_icon] placeholderImage:nil];
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
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",(long)button.tag] forKey:@"party_id"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"nsuser is %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"party_id"]);

}
- (void)callLeaderInfo
{
    LeaderInfoController *leaderDetail =[[LeaderInfoController alloc]initWithNibName:@"LeaderInfoController" bundle:nil];
    
    [self.navigationController pushViewController:leaderDetail animated:YES];
    
  
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
