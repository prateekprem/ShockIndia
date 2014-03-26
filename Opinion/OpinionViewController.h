//
//  OpinionViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface OpinionViewController : UIViewController <XYPieChartDelegate, XYPieChartDataSource>

@property (strong, nonatomic) IBOutlet XYPieChart *pieChartRight;
@property (strong, nonatomic) IBOutlet XYPieChart *pieChartLeft;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property (strong, nonatomic) IBOutlet UITextField *numOfSlices;
@property (strong, nonatomic) IBOutlet UISegmentedControl *indexOfSlices;
@property (strong, nonatomic) IBOutlet UIButton *downArrow;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSMutableArray *slices1;

@property(nonatomic, strong) NSArray        *sliceColors;
@property(nonatomic, strong) NSString        *userLeader;
@property(nonatomic, strong) NSString        *userParty;
@property(assign) NSInteger   partyid;
@property(assign) NSInteger   leaderid;

@end
