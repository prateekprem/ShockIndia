//
//  StoryView.m
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "StoryFullRead.h"

@implementation StoryFullRead
@synthesize story_detail = story_detail_;
@synthesize story_name = story_name_;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"StoryFullRead" owner:self options:nil]objectAtIndex:0];
        subView.frame = self.frame;
        [self addSubview:subView];
        // Initialization code
    }
    return self;
}
- (IBAction)close:(id)sender
{
    [self removeFromSuperview];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
