//
//  QuizViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Question;


@interface QuizViewController : UIViewController
{
    int points;
}
@property(strong,nonatomic) NSMutableArray  *questionNoArray;
@property(strong,nonatomic) NSString *strCorrectOption;
@property (strong, nonatomic) IBOutlet UILabel *lblPointText;

@property (strong, nonatomic) IBOutlet UILabel *lblpoints;
@property(strong,nonatomic) IBOutlet  UILabel *questionLabel;
@property(strong,nonatomic) IBOutlet  UIButton *questiontitleLabel;

@property(strong,nonatomic) IBOutlet  UILabel *questionNoLabel;

@property(strong,nonatomic) IBOutlet  UIButton *answerbtn1;
@property(strong,nonatomic) IBOutlet  UIButton *answerbtn2;
@property(strong,nonatomic) IBOutlet  UIButton *answerbtn3;
- (IBAction)btn1Clicked:(UIButton *)sender;
- (IBAction)btn2Clicked:(UIButton *)sender;
- (IBAction)btn3Clicked:(UIButton *)sender;
- (void)getarray:(NSArray *)array;
@end
