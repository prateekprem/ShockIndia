//
//  FactViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fact;
@class WEPopoverController;

@interface FactViewController : UIViewController
{
    IBOutlet UITableView *factTable;
     Fact *factObj;
     UIButton *buttonRef;
}
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong) WEPopoverController *popoverController;
- (IBAction)submit:(id)sender;
- (void)getFactsArray:(NSArray *)array;
@end
