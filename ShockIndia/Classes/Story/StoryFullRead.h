//
//  StoryView.h
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryFullRead : UIView

@property (nonatomic, strong) IBOutlet UITextView *story_detail;
@property (nonatomic, strong) IBOutlet UILabel *story_name;
- (IBAction)close:(id)sender;

@end
