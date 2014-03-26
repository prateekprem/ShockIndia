//
//  FactCell.h
//  ShockIndia
//
//  Created by Divya Sharma on 03/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactCell : UITableViewCell
@property (nonatomic, strong)IBOutlet UITextView *textView;
- (IBAction)shockedButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnShocked;
@property (nonatomic, strong)IBOutlet UILabel *byLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnComment;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@end
