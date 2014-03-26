//
//  StoryCell.h
//  ShockIndia
//
//  Created by NZT Solutions on 09/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Story;
@class WEPopoverController;




@interface StoryCell : UITableViewCell
{
    WEPopoverController *popoverController;
    IBOutlet UIImageView *story_pic;
    IBOutlet UILabel *story_title_label;
    IBOutlet UILabel *comments_label;

    IBOutlet UILabel *shares_label;
    IBOutlet UILabel *shocks_label;
    IBOutlet UILabel *story_description_label;
    Story *storyObj;
}
@property (nonatomic, strong)IBOutlet UILabel *story_by;
- (IBAction)shockButtonTapped:(id)sender;

@property (nonatomic, strong)IBOutlet UILabel *story_title_label;
@property (nonatomic, strong)IBOutlet UIButton *btnShare;
@property (nonatomic, strong)IBOutlet UIButton *btnShock;
@property (nonatomic, strong)IBOutlet UIButton *btnComment;
@property (nonatomic, retain) WEPopoverController *popoverController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier datasource:(Story *)story;
- (IBAction)readFullStory:(UIButton *)sender;
@end
