//
//  LeaderDetailViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "LeaderDetailViewController.h"
#import "FHSTwitterEngine.h"
#import <MessageUI/MessageUI.h>
#import "Leaders.h"
#import <QuartzCore/QuartzCore.h>
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"

@interface LeaderDetailViewController ()

@end

@implementation LeaderDetailViewController
@synthesize popoverController = popoverController_;

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
    [[Global sharedController]addTopBar:self];


    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"Xg3ACDprWAH8loEPjMzRg" andSecret:@"9LwYDxw1iTc6D9ebHdrYCZrJP4lJhQv5uf4ueiPHvJ0"];
    [[FHSTwitterEngine sharedEngine]setDelegate: (id)self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    [[Global sharedController]addTopBar:self];

    NSString *iconStr=self.leaderObj.leaders_images;
    NSString *descriptionstr=self.leaderObj.leaders_detail;
    [self.leaderIconImageView setImageWithURL:[NSURL URLWithString:iconStr]];
     self.lblLeaderName.text=self.leaderObj.leaders_name;
    self.leaderIconImageView.layer.borderColor = UIColorFromRGB(0x6cab36).CGColor;
    self.leaderIconImageView.layer.borderWidth = 2;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[descriptionstr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.leaderDetailTextView.attributedText = attributedString;
     [self.leaderDetailTextView setFont:[UIFont systemFontOfSize:15]];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareOnSocialSite:(id)sender
{
    [self.btnComment setSelected:NO];
    [self.btnShare setSelected:YES];
    [self.btnShocks  setSelected:NO];

    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"FaceBook", @"Twitter",@"WhatsApp",@"Send Mail", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [shareActionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    { //[self postOnFaceBook];
    }
    else if (buttonIndex == 1)
           {
               [self postOnTwitter];
          
           }
    else if (buttonIndex == 2)
    {
        [self postOnWhatsApp];

    }
    else if (buttonIndex == 3)
        
            {
                [self sendMail];
                
            
            }
 
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
//        
//        NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
//		
//		[variables setObject:self.leaderDetailTextView.text forKey:@"message"];
//		[variables setObject:@"" forKey:@"link"];
//		[variables setObject:@"" forKey:@"name"];
//		[variables setObject:@"" forKey:@"description"];
//		
//		
//		
//		FbGraphResponse *fb_graph_response = [self.fbGraph doGraphPost:@"me/feed" withPostVars:variables];
//		
//		
//		if (fb_graph_response) {
//			UIAlertView *successalert =[[UIAlertView alloc] initWithTitle:@"" message:@"your message successfully posted on facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			[successalert show];
//              [self callShareservice];
//		}
//        
//	}
//	
//}
-(void)postOnTwitter
{
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
    }];
    [self presentViewController:loginController animated:YES completion:nil];
    
    FHSTwitterEngine *engine =  [FHSTwitterEngine sharedEngine];
    NSError *error = [engine postTweet:self.leaderDetailTextView.text];
    
    if (error == nil) {
        
        NSLog(@"post succesFull");
        //[self callShareservice];
    }else{
        [error localizedDescription];
        NSLog(@"error is %@",[error localizedDescription]);
        [self callShareservice];
    }
}
-(void)sendMail
{
    NSString *emailTitle = @"Shock India";
    // Email Content
    NSString *messageBody =self.leaderDetailTextView.text ;
    // To address
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = (id)self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
           
              [self callShareservice];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
     [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)postOnWhatsApp
{
    if ([WhatsAppKit isWhatsAppInstalled]) {
        [WhatsAppKit launchWhatsAppWithMessage:self.leaderDetailTextView.text ];
        [self callShareservice];
    }

}


- (IBAction)shockedBtnClicked:(UIButton *)button {
    [self.btnComment setSelected:NO];
    [self.btnShare setSelected:NO];
    [self.btnShocks  setSelected:YES];
    
    
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockPost,@"action",@"leaderdetail",@"shock_on_type",button.tag,@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(shockButtonDisable) delegate:self];
    
}
-(void)callShareservice
{
    
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionSharePost,@"action",@"leader_detail",@" share_on_type",buttonRef.tag,@"share_on_id ",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShare] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    
}
-(void)shockButtonDisable
{
    self.btnShocks.enabled=NO;
}
-(void)getArray:(NSArray*)array
{
    
    
    if (self.popoverController) {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
    }
    
	else {
		
		WEPopoverContentViewController *contentViewController=[[WEPopoverContentViewController alloc]init];
        contentViewController.dataSource=array;
		self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController] ;
        CGRect frame = [buttonRef convertRect:buttonRef.bounds toView:self.view];
        //frame.size.height = 300;
        
		[self.popoverController presentPopoverFromRect:frame
												inView:self.view
							  permittedArrowDirections:UIPopoverArrowDirectionUp
											  animated:YES];
	}
}


- (IBAction)commentBtnClicked:(UIButton*)button
{
    buttonRef=button;
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"leader_detail",@"comment_on_type",button.tag,@"comment_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(getArray:) delegate:self];
    [self.btnComment setSelected:YES];
    [self.btnShare setSelected:NO];
    [self.btnShocks  setSelected:NO];

}
@end
