//
//  StoryView.m
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "StoryView.h"

@implementation StoryView
@synthesize delegate;
@synthesize story_detail = story_detail_;
@synthesize story_name = story_name_;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"StoryView" owner:self options:nil]objectAtIndex:0];
        subView.frame = self.frame;
        [self.story_name becomeFirstResponder];
        [self addSubview:subView];
        // Initialization code
    }
    return self;
}
- (IBAction)close:(id)sender
{
    [self removeFromSuperview];

}
- (IBAction)submitstory:(id)sender
{
    if (![self.story_name.text length]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a story title." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (![self.story_detail.text length]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter some story description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
    [self.delegate submitStory:self.story_name.text storyDetail:self.story_detail.text];
    [self removeFromSuperview];
     }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    story.hidden = TRUE;

    if ([textView.text length]>4000) {
        return FALSE;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length]>100) {
        return FALSE;
    }
    return YES;


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self endEditing:YES];
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
