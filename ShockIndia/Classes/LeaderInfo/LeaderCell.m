//
//  LeaderCell.m
//  ShockIndia
//
//  Created by NZT Solutions on 09/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "LeaderCell.h"
#import "LeaderDetailViewController.h"
#import "LeaderInfoViewController.h"

@implementation LeaderCell
@synthesize party1_label = party1_label_;
@synthesize party2_label = party2_label_;
@synthesize party1_image = party1_image_;
@synthesize party2_image = party2_image_;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
