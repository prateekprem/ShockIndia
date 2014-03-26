//
//  PartyInfoViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "PartyInfoViewController.h"
#import "Global.h"
#import "SWRevealViewController.h"
#import "PartyDetailViewController.h"
#import "PartyCell.h"
#import "Parties.h"
#import "Constants.h"

@interface PartyInfoViewController ()

@end

@implementation PartyInfoViewController
@synthesize btnAll =btnAll_;
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
    self.array = [[NSMutableArray alloc]initWithArray:[[DataBaseController sharedController]getPartiesData]];
    [self.btnAll sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.partyTableView reloadData];
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count]/2;
    NSLog(@"data source count is %lu",(unsigned long)[self.dataSource count]);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier =@"identifier";
    
    PartyCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    
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
        Parties *obj1 = [self.dataSource objectAtIndex:index+1];
        cell.btn1.tag=index+1;
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
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    Parties *obj   = [self.dataSource objectAtIndex:button.tag];
    if (IS_IPHONE_5) {
        PartyDetailViewController *partyDetail =[[PartyDetailViewController alloc]initWithNibName:@"PartyDetailViewController" bundle:nil];
        [self.navigationController pushViewController:partyDetail animated:YES];
        [partyDetail  setPartiesObj:obj];

    }
    else
    {
    
    
        PartyDetailViewController *partyDetail =[[PartyDetailViewController alloc]initWithNibName:@"PartyDetailViewController1" bundle:nil];
        [self.navigationController pushViewController:partyDetail animated:YES];
        [partyDetail  setPartiesObj:obj];
    
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
- (IBAction)allbtnClicked:(id)sender
{
    self.dataSource=self.array;
    [self.partyTableView reloadData];

    [self.btnAll setSelected:YES];
    [self.btnThirdFront setSelected:NO];
    [self.btnNda setSelected:NO];
    [self.btnUpa setSelected:NO];

}
- (IBAction)thirdFrontClicked:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (Parties *obj in self.array) {
        if ([obj.parties_type isEqualToString:@"Third front"]) {
            [array addObject:obj];
        }
    }
    self.dataSource = array;
    [self.partyTableView reloadData];

    [self.btnAll setSelected:NO];
    [self.btnThirdFront setSelected:YES];
    [self.btnNda setSelected:NO];
    [self.btnUpa setSelected:NO];
}

- (IBAction)upaBtnClicked:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (Parties *obj in self.array) {
        if ([obj.parties_type isEqualToString:@"UPA"]) {
            [array addObject:obj];
        }
    }
    self.dataSource = array;
    [self.partyTableView reloadData];

    [self.btnAll setSelected:NO];
    [self.btnThirdFront setSelected:NO];
    [self.btnNda setSelected:NO];
    [self.btnUpa setSelected:YES];
}
- (IBAction)ndabtnClicked:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (Parties *obj in self.array) {
        if ([obj.parties_type isEqualToString:@"NDA"]) {
            [array addObject:obj];
        }
    }
    self.dataSource = array;
    
    [self.partyTableView reloadData];

    
    [self.btnAll setSelected:NO];
    [self.btnThirdFront setSelected:NO];
    [self.btnNda setSelected:YES];
    [self.btnUpa setSelected:NO];
}
@end
