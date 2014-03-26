//
//  StoryView.m
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "FactView.h"

@implementation FactView
@synthesize delegate;
@synthesize fact_detail = fact_detail_;
@synthesize fact_name = fact_name_;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"FactView" owner:self options:nil]objectAtIndex:0];
        subView.frame = self.frame;
        [self addSubview:subView];
        [self.fact_detail becomeFirstResponder];
        // Initialization code
    }
    return self;
}
- (IBAction)close:(id)sender
{    [self removeFromSuperview];

}
- (IBAction)submit:(id)sender
{
     if (![self.fact_detail.text length]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter some fact description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.fact_detail.text length]>100) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Fact description more than 100 characters not allowed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
    [self.delegate submitFact:self.fact_name.text factDetail:self.fact_detail.text];
    [self removeFromSuperview];
     }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    fact.hidden = TRUE;

    if ([textView.text length]>100) {
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
