//
//  HomeViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 01/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
    int imageIndex;
    IBOutlet UIImageView *animateImageView;
}
@property (strong, nonatomic)UIImageView *splashView;
@property (strong, nonatomic) IBOutlet UIButton *btnPoll;

- (IBAction)whyVotebtnTap:(UIButton *)sender;
- (IBAction)factbtnTap:(UIButton *)sender;
- (IBAction)profilebtnTap:(UIButton *)sender;
- (IBAction)quizbtnTap:(UIButton *)sender;
-(void)goToAboutUsView;
- (IBAction)pollbtnTap:(UIButton *)sender;
@end
