//
//  OpinionViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "OpinionViewController.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "Poll.h"


@interface OpinionViewController ()
- (void)postUserOpinionPoll;
@end

@implementation OpinionViewController
@synthesize pieChartRight = _pieChart;
@synthesize pieChartLeft = _pieChartCopy;
@synthesize percentageLabel = _percentageLabel;
@synthesize selectedSliceLabel = _selectedSlice;
@synthesize numOfSlices = _numOfSlices;
@synthesize indexOfSlices = _indexOfSlices;
@synthesize downArrow = _downArrow;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;
@synthesize userLeader = _userLeader;
@synthesize userParty = _userParty;
@synthesize slices1 = slices1_;
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
    [self drawChart];
    [self drawChart1];
    //[self postUserOpinionPoll];
     //_slices=[[[DataBaseController sharedController]getPartiesData]mutableCopy];
    
   
}
- (void)drawChart1
{
    self.slices1 = [[NSMutableArray alloc]init];
    NSArray *array = [NSArray arrayWithObjects:@"50",@"25",@"25",nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"BJP (50%)",@"AAP (25%)",@"INC (25%)",nil];

    for(NSString *str in array)
    {
        
        NSNumber *one = [NSNumber numberWithInt:[str intValue]];
        [self.slices1 addObject:one];
    }

    [self.pieChartRight setDataSource:self];
    [self.pieChartRight setStartPieAngle:M_PI_2];
    [self.pieChartRight setAnimationSpeed:1.0];
    [self.pieChartRight setLabelFont:[UIFont systemFontOfSize:14]];
    [self.pieChartRight setLabelRadius:100];
    [self.pieChartRight setShowPercentage:YES];
    [self.pieChartRight setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartRight setPieCenter:CGPointMake(90, 140)];
    [self.pieChartRight setUserInteractionEnabled:NO];
    [self.pieChartRight setLabelColor:[UIColor darkGrayColor]];
   // [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
    [self.pieChartRight setPartyText:array1];
   
    [self.percentageLabel.layer setCornerRadius:60];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    //rotate up arrow
    self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
    // Do any additional setup after loading the view from its nib.
    
}



- (void)drawChart
{
    self.slices = [[NSMutableArray alloc]init];
    NSArray *array = [NSArray arrayWithObjects:@"20",@"50",@"30" ,nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"Rahul (20%)",@"Narendra Modi (50%)",@"Kejriwal (30%)",nil];


    for(NSString *str in array)
    {
        
        NSNumber *one = [NSNumber numberWithInt:[str intValue]];
        [_slices addObject:one];
    }
    
    [self.pieChartLeft setDataSource:self];
    [self.pieChartLeft setStartPieAngle:M_PI_2];
    [self.pieChartLeft setAnimationSpeed:1.0];
    [self.pieChartLeft setLabelFont:[UIFont systemFontOfSize:15]];
    [self.pieChartLeft setLabelRadius:100];
    [self.pieChartLeft setShowPercentage:YES];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartLeft setPieCenter:CGPointMake(150, 150)];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    //[self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
    [self.pieChartLeft setPartyText:array1];
    [self.pieChartLeft setLabelColor:[UIColor darkGrayColor]];
    //[self.percentageLabel.layer setCornerRadius:50];
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    //rotate up arrow
    self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
    // Do any additional setup after loading the view from its nib.

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (void)viewDidUnload
{
    [self setPieChartLeft:nil];
    [self setPieChartRight:nil];
    [self setPercentageLabel:nil];
    [self setSelectedSliceLabel:nil];
    [self setIndexOfSlices:nil];
    [self setNumOfSlices:nil];
    [self setDownArrow:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SliceNumChanged:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger num = self.numOfSlices.text.intValue;
    if(btn.tag == 100 && num > -10)
        num = num - ((num == 1)?2:1);
    if(btn.tag == 101 && num < 10)
        num = num + ((num == -1)?2:1);
    
    //self.numOfSlices.text = [NSString stringWithFormat:@"%d",num];
}

- (IBAction)clearSlices {
    [_slices removeAllObjects];
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (IBAction)addSliceBtnClicked:(id)sender
{
    NSInteger num = [self.numOfSlices.text intValue];
    if (num > 0) {
        for (int n=0; n < abs(num); n++)
        {
            NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
            NSInteger index = 0;
            if(self.slices.count > 0)
            {
                switch (self.indexOfSlices.selectedSegmentIndex) {
                    case 1:
                        index = rand()%self.slices.count;
                        break;
                    case 2:
                        index = self.slices.count - 1;
                        break;
                }
            }
            [_slices insertObject:one atIndex:index];
        }
    }
    else if (num < 0)
    {
        if(self.slices.count <= 0) return;
        for (int n=0; n < abs(num); n++)
        {
            NSInteger index = 0;
            if(self.slices.count > 0)
            {
                switch (self.indexOfSlices.selectedSegmentIndex) {
                    case 1:
                        index = rand()%self.slices.count;
                        break;
                    case 2:
                        index = self.slices.count - 1;
                        break;
                }
                [_slices removeObjectAtIndex:index];
            }
        }
    }
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (IBAction)updateSlices
{
    for(int i = 0; i < _slices.count; i ++)
    {
        [_slices replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:rand()%10+20]];
    }
    [self.pieChartLeft reloadData];
    [self.pieChartRight reloadData];
}

- (IBAction)showSlicePercentage:(id)sender {
    UISwitch *perSwitch = (UISwitch *)sender;
    [self.pieChartRight setShowPercentage:perSwitch.isOn];
}
- (void)postUserOpinionPoll
{
    
    BOOL bool_vote = [[NSUserDefaults standardUserDefaults]boolForKey:@"vote"];
   if (bool_vote) {
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionOpinionGet,@"action", nil];
        [[ServerController sharedController]callWebServiceGetJsonResponse:kOpinionUrl userInfo:dict withSelector:@selector(getarray:) delegate:self];
       return;
    }
    
    NSString *partyid = [[NSUserDefaults standardUserDefaults]objectForKey:@"party_id"];
    
    NSString *leaderid = [[NSUserDefaults standardUserDefaults]objectForKey:@"leader_id"];

    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];

    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:[NSDate date]];
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionOpinionPost,@"action",dateString,@"date",user_id,@"user_id",leaderid,@"leader",partyid,@"party", nil];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kOpinionUrl userInfo:dict withSelector:@selector(getarray:) delegate:self];
    



}
- (void)getarray:(NSArray *)array
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"vote"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self drawChart];


}
#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    
    int no = 0;
    if (pieChart==self.pieChartLeft) {
        no = _slices.count;
    }
    else
    {
        no = self.slices1.count;

    }
    
    return no;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    
    CGFloat no = 0;
    if (pieChart==self.pieChartLeft) {
        no = [[_slices objectAtIndex:index] intValue];
    }
    else
    {
        no = [[self.slices1 objectAtIndex:index] intValue];
        
    }
    
    return no;
    
}


- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if(pieChart == self.pieChartRight) return nil;
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}

@end
