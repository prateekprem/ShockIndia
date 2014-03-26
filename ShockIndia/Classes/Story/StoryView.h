//
//  StoryView.h
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol storyProtocol <NSObject>
- (void)submitStory:(NSString *)storyName storyDetail:(NSString *)story_detail;
@end
@interface StoryView : UIView
{
    id<storyProtocol> delegate;
    IBOutlet UILabel *story;

}
@property (nonatomic, strong)  id<storyProtocol> delegate;

@property (nonatomic, strong) IBOutlet UITextView *story_detail;
@property (nonatomic, strong) IBOutlet UITextField *story_name;
- (IBAction)close:(id)sender;
- (IBAction)submitstory:(id)sender;

@end
