//
//  PartyInfoViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *partyTableView;
@property (strong, nonatomic) IBOutlet UIButton *btnNda;
@property (strong, nonatomic) IBOutlet UIButton *btnUpa;
@property (strong, nonatomic) IBOutlet UIButton *btnAll;
@property (strong, nonatomic)NSMutableArray *array;
- (IBAction)ndabtnClicked:(id)sender;
- (IBAction)allbtnClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnThirdFront;
- (IBAction)thirdFrontClicked:(id)sender;
- (IBAction)upaBtnClicked:(id)sender;
@property (strong,nonatomic) NSMutableArray *dataSource;
@end
