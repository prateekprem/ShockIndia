//
//  ProfileViewController.h
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *points;
    IBOutlet UITextField *addressTxt;
    IBOutlet UITextField *ageTxt;
    IBOutlet UITextField *emailTxt;
    IBOutlet UITextField *phoneTxt;
    IBOutlet UITextField *fblinkTxt;
    IBOutlet UITextField *twitterlinkTxt;
    IBOutlet UITextField *countryTxt;
    IBOutlet UITextField *politicalViewTxt;
    IBOutlet UITextField *genderTxt;

    IBOutlet UIButton *photoBtn;

    IBOutlet UIButton *genderBtn;

    IBOutlet UIButton *profileBtn;



}
@property (assign) NSInteger point;
@property (strong, nonatomic) IBOutlet UILabel *lblPoints;
- (IBAction)btnTapProfileUpdate:(UIButton *)sender;
- (IBAction)btnTapFillInFromFacebook:(id)sender;
- (IBAction)btnTapPhoto:(id)sender;
- (IBAction)btnTapGender:(UIButton *)sender;

@end
