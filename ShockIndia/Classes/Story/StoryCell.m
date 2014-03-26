//
//  StoryCell.m
//  ShockIndia
//
//  Created by NZT Solutions on 09/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "StoryCell.h"
#import "StoryFullRead.h"
#import "Story.h"
#import "AnimateViews.h"
#import "UIImageView+AFNetworking.h"
#define kStory @"story"
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"


@implementation StoryCell
@synthesize story_title_label = story_title_label_;
@synthesize btnShare = btnShare_;
@synthesize story_by = story_by_;

- (void)getShocks:(NSString *)story_id
{
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockGet,@"action",@"story",@"shock_on_type",story_id,@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(getNoOfShocks:) delegate:self];


}

- (void)getNoOfShocks:(NSArray *)shocks
{
    if (![shocks count]) {
        return;
    }
    shocks_label.text = @"90";


}

- (void)getShares:(NSString *)story_id
{
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionshareGet,@"action",@"story",@"share_on_type",story_id,@"share_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShare] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:@selector(getNoOfShares:) delegate:self];
    
    
}

- (void)getNoOfShares:(NSArray *)shocks
{
    if (![shocks count]) {
        return;
    }
    shares_label.text = [shocks objectAtIndex:0];
    
    
}

- (void)getComments:(NSString *)story_id
{
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"story",@"comment_on_type",story_id,@"comment_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(getNoOfComments:) delegate:self];
    
    
}

- (void)getNoOfComments:(NSArray *)shocks
{
    if (![shocks count]) {
        return;
    }
    comments_label.text = [shocks objectAtIndex:0];
    
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier datasource:(Story *)story
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        storyObj = story;
        StoryCell *view = [[[NSBundle mainBundle]loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
        self.story_by.text = story.story_posted_by;
        self.btnShock.tag = story.story_id;
        self.story_title_label.text =  [NSString stringWithFormat:@"%@",story.story_name] ;
        [story_pic setImageWithURL:[NSURL URLWithString:story.story_pic] placeholderImage:nil];
        NSString *story_id = [NSString stringWithFormat:@"%d",story.story_id];
       

        [self getShocks:story_id];
        [self performSelectorInBackground:@selector(getShares:) withObject:story_id];
        [self performSelectorInBackground:@selector(getComments:) withObject:story_id];

        [self addSubview:view];

        // Initialization code
    }
    return self;
}
- (IBAction)readFullStory:(UIButton *)sender
{
    StoryFullRead *storyView;
    if (IS_IPHONE_5) {
        storyView =  [[StoryFullRead alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    }
    else
    {
        storyView =  [[StoryFullRead alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        
    }
    storyView.story_detail.text = storyObj.story_detail;
    storyView.story_name.text = storyObj.story_name;
    
    
    [appDelegate.window addSubview:storyView];
    [[AnimateViews allocate] startAnimationOnview:storyView toView:nil animationType:BounceViewAnimationType animationSubType:0];
}



    
    

-(void)shockButtonDisable
{
    self.btnShock.enabled=NO;
}

- (IBAction)shockButtonTapped:(UIButton *)sender
{

    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockPost,@"action",kStory,@"shock_on_type",[NSString stringWithFormat:@"%d",sender.tag],@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(shockButtonDisable) delegate:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
