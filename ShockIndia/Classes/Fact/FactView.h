//
//  StoryView.h
//  ShockIndia
//
//  Created by Divya Sharma on 13/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol factProtocol <NSObject>
- (void)submitFact:(NSString *)name factDetail:(NSString *)detail;
@end
@interface FactView : UIView
{
    id<factProtocol> delegate;
    IBOutlet UILabel *fact;

}
@property (nonatomic, strong)  id<factProtocol> delegate;

@property (nonatomic, strong) IBOutlet UITextView *fact_detail;
@property (nonatomic, strong) IBOutlet UITextField *fact_name;
- (IBAction)close:(id)sender;
- (IBAction)submit:(id)sender;

@end
