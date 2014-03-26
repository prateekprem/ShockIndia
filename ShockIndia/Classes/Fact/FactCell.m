//
//  FactCell.m
//  ShockIndia
//
//  Created by Divya Sharma on 03/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "FactCell.h"
#import <QuartzCore/QuartzCore.h>
#define kfact @"fact"


@implementation FactCell
@synthesize textView = textView_;
@synthesize byLabel = byLabel_;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         FactCell *view = [[[NSBundle mainBundle]loadNibNamed:@"FactCell" owner:self options:nil]objectAtIndex:0];
        view.byLabel.text = @"Shock India";
        //view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //view.layer.borderWidth = 1;
        [self addSubview:view];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)shockButtonDisable
{
   self.btnShocked.enabled=NO;
}

- (IBAction)shockedButtonClicked:(id)sender
{
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockPost,@"action",kfact,@"shock_on_type",@"1",@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(shockButtonDisable) delegate:self];
}
//- (IBAction)commentButtonClicked:(id)sender
//
//{
//   
//}
@end
