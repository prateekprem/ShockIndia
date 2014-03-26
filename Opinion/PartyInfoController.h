//
//  PartyInfoController.h
//  ShockIndia
//
//  Created by NZT Solutions on 12/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartyCell;

@interface PartyInfoController : UIViewController
{

 

}
@property (strong, nonatomic) IBOutlet UITableView *partyTableView;

//- (IBAction)ndabtnClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnThirdFront;
//- (IBAction)thirdFrontClicked:(id)sender;
//- (IBAction)upaBtnClicked:(id)sender;
@property (strong,nonatomic) NSMutableArray *dataSource;

@end
