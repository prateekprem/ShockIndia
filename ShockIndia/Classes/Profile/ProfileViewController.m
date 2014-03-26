//
//  ProfileViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "ProfileViewController.h"
#import "Global.h"
#import "User.h"
@interface ProfileViewController ()
- (void)isEditable;
- (void)callUpdateProfile;
@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    User *user = [[DataBaseController sharedController]getMyProfileData];
    username.text = user.user_name;
    points.text = user.user_age;
    emailTxt.text = user.user_email;
    phoneTxt.text = user.user_phone;
    fblinkTxt.text = user.user_fb_link;
    addressTxt.text = user.user_address;
    [genderBtn setTitle:user.user_gender forState:UIControlStateNormal];
    self.lblPoints.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"point"];

    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [[Global sharedController]addTopBar:self];

}
- (void)callUpdateProfile
{
    if (![phoneTxt.text length]) {
        phoneTxt.text = @"";
    }
    if (![emailTxt.text length]) {
        emailTxt.text = @"";
    }
    if (![addressTxt.text length]) {
        addressTxt.text = @"";
    }
    if (![ageTxt.text length]) {
        ageTxt.text = @"";
    }
    if (![genderTxt.text length]) {
       genderTxt.text = @"";
    }
    if (![fblinkTxt.text length]) {
        fblinkTxt.text = @"";
    }
    if (![twitterlinkTxt.text length]) {
        twitterlinkTxt.text = @"";
    }
    if (![politicalViewTxt.text length]) {
        politicalViewTxt.text = @"";
    }
    if (![countryTxt.text length]) {
        countryTxt.text = @"";
    }

    NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];

   NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:username.text,@"name",phoneTxt.text,@"mobile",emailTxt.text,@"email",kActionProfileUpdate,@"action",addressTxt.text,@"address",ageTxt.text,@"age",genderBtn.currentTitle,@"gender",fblinkTxt.text,@"fb_link",twitterlinkTxt.text,@"twitter_link",politicalViewTxt.text,@"political_view",[string intValue],@"user_id",@"",@"country",points.text,@"points", nil];
    [dict setObject:string forKey:@"photo"];
    NSData *imageData= UIImageJPEGRepresentation(photoBtn.currentImage, 0.5);
    if (imageData) {
        [dict setObject:imageData forKey:@"data"];

    }
    
    [[ServerController sharedController]callWebServiceGetJsonResponse:kUserUrl userInfo:dict withSelector:@selector(sucesss) delegate:self];

}
- (IBAction)btnTapGender:(UIButton *)sender
{
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"Male", @"Female",@"Other", nil];
    shareActionSheet.tag = 99;
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [shareActionSheet showInView:self.view];

}
-(void)sucesss
{
    UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Your profile updated sucessfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==username) {
        [ageTxt becomeFirstResponder];
    }
    else if(textField==ageTxt ) {
        [emailTxt becomeFirstResponder];
        
    }
    else if (textField==emailTxt) {
        if ([self validateEmail:emailTxt.text]) {
            [phoneTxt becomeFirstResponder];
        }
        else
        {
            UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Email is invalid" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        
        
        }
        
        
    }
    

    
    if (textField==phoneTxt) {
            
            
            [addressTxt becomeFirstResponder];
        }
        else if (textField==addressTxt) {
            
            
            [politicalViewTxt becomeFirstResponder];
        }
    
        else if (textField==politicalViewTxt) {
            
            
            [fblinkTxt becomeFirstResponder];
        }
        else if (textField==fblinkTxt) {
            
            
            [twitterlinkTxt becomeFirstResponder];
        }
    else if(textField == twitterlinkTxt)
    {
        [textField resignFirstResponder];
    
    
    }
    

return YES;
    
}




- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == ageTxt) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }     else if (textField==genderTxt) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];    }
    else if (textField==emailTxt) {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
            }



    if (textField==phoneTxt) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else if (textField==addressTxt) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];    }
    
    else if (textField==politicalViewTxt) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 60.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else if (textField==fblinkTxt) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 90.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else if (textField==twitterlinkTxt) {
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 170.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];

  
}


- (IBAction)btnTapFillInFromFacebook:(id)sender {
   // [self postOnFaceBook];
   }


//-(void)postOnFaceBook
//{
//    
//    [self.fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
//                              andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
//    
//}
//- (void)fbGraphCallback:(id)sender {
//	
//	if ( (self.fbGraph.accessToken == nil) || ([self.fbGraph.accessToken length] == 0) ) {
//		
//		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
//		
//		//restart the authentication process.....
//		[self.fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:)
//                                  andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins"];
//		
//	}
//	else
//	{
//		
//        NSLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", self.fbGraph.accessToken);
//       
//		FbGraphResponse *fb_graph_response = [self.fbGraph doGraphGet:@"me" withGetVars:nil];
//        NSError *error = nil;
//        NSDictionary *response_dict = [NSJSONSerialization JSONObjectWithData:fb_graph_response.htmlResponse options: NSJSONReadingMutableContainers error: &error];
//         NSLog(@"responce dict keys  %@", [response_dict allKeys]);
//        username.text =[response_dict objectForKey:@"name"];
//       emailTxt.text = [response_dict objectForKey:@"email"];
//        genderTxt.text=[response_dict objectForKey:@"gender"];
//        
//        
//        
//
//		}
//        
//	}




-(BOOL) validateEmail: (NSString *) user {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:user];
}

- (void)isEditable
{
    BOOL enable = profileBtn.selected;
    username.userInteractionEnabled = enable;
    points.userInteractionEnabled = enable;
    addressTxt.userInteractionEnabled = enable;
    ageTxt.userInteractionEnabled = enable;
     genderBtn.userInteractionEnabled = enable;
    emailTxt.userInteractionEnabled = enable;
    phoneTxt.userInteractionEnabled = enable;
    fblinkTxt.userInteractionEnabled = enable;
    twitterlinkTxt.userInteractionEnabled = enable;
    countryTxt.userInteractionEnabled = enable;
    politicalViewTxt.userInteractionEnabled = enable;
    genderBtn.userInteractionEnabled = enable;
    photoBtn.userInteractionEnabled = enable;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTapProfileUpdate:(UIButton *)sender
{
    sender.selected = !sender.selected;
     [self isEditable];
    if (sender.selected ) {
        return;
    }
     if ([username.text length]&&([phoneTxt.text length]||[emailTxt.text length]))
         
     {
         
         if([emailTxt.text length]){
         if (![self validateEmail:emailTxt.text]) {
         
             UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Email is invalid" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
         }
         else
         {
             if (!sender.selected) {
                 [self callUpdateProfile];
             }
         }
         }
         
    }
     else {
         if (![username.text length]){
         UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Enter your name." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
         [alert show];
         }
         else if (([phoneTxt.text length]||[emailTxt.text length])){
             UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Enter email or phone." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
         }
             
     }

}



- (IBAction)btnTapPhoto:(id)sender
{
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"Take a new photo", @"Choose from existing", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [shareActionSheet showInView:self.view];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 99) {
        if (buttonIndex == 0)
        {
            genderTxt.text = @"Male";
            
        }
        else if (buttonIndex == 1)
        {
            genderTxt.text = @"Female";
            
        }
        else if (buttonIndex == 2)
        {
            genderTxt.text = @"Other";
            
        }
        
        return;
    }
    
    if (buttonIndex == 0)
    {
        [self takeNewPhotoFromCamera];

    }
    else if (buttonIndex == 1)
    {
        [self choosePhotoFromExistingImages];
 
    }
}

- (void)takeNewPhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
    else{
        UIAlertView  *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Camera not available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    
    }
}
-(void)choosePhotoFromExistingImages
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        [self.navigationController presentViewController: controller animated: YES completion: nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:  UIImagePickerControllerOriginalImage  ];
    
    
    photoBtn.imageView.image = image;
    
    NSLog(@"show info %@",info);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [username resignFirstResponder];
    [points resignFirstResponder];
    [addressTxt resignFirstResponder];
    [ageTxt resignFirstResponder];
    [emailTxt resignFirstResponder];
    [phoneTxt resignFirstResponder];
    [fblinkTxt resignFirstResponder];
    [twitterlinkTxt resignFirstResponder];
    [countryTxt resignFirstResponder];
    [politicalViewTxt resignFirstResponder];
    [politicalViewTxt resignFirstResponder];
    [self.view endEditing:YES];


    
}
@end
