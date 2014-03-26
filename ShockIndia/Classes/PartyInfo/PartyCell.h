//
//  PartyCell.h
//  ShockIndia
//
//  Created by NZT Solutions on 09/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIButton *btn;
@property(strong,nonatomic)IBOutlet UIButton *btn1;
@property(strong,nonatomic)IBOutlet UILabel *party1_label;
@property(strong,nonatomic)IBOutlet UILabel *party2_label;
@property(strong,nonatomic)IBOutlet UIImageView *party1_image;
@property(strong,nonatomic)IBOutlet UIImageView *party2_image;

@end
