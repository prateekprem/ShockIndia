//
//  SignUpViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 05/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic)  NSString * fbid;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirnPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtEmailId;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic) NSMutableArray *recordArray;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) UIImageView *splashView;
@property (strong, nonatomic) FBRequestConnection *requestConnection;

- (IBAction)termstap:(id)sender;
- (IBAction)signUp:(id)sender;
- (IBAction)loginUsingFaceBook:(id)sender;
@end
