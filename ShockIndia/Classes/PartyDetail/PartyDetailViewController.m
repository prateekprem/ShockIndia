//
//  PartyDetailViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "PartyDetailViewController.h"
#import "Parties.h"
#import "FHSTwitterEngine.h"
#import <MessageUI/MessageUI.h>
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"

@interface PartyDetailViewController ()

@end

@implementation PartyDetailViewController
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
    NSString *iconStr=self.partiesObj.parties_images;
    NSString *descriptionstr=self.partiesObj.parties_detail;
    [self.partiesIconImageView setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:nil];
    
    self.title = self.partiesObj.parties_short_name;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[descriptionstr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.partyDescriptionTextView.attributedText = attributedString;
    [self.partyDescriptionTextView setFont:[UIFont systemFontOfSize:15]];
    self.lblPartyname.text=self.partiesObj.parties_name;
    
    self.partiesIconImageView.layer.borderColor = UIColorFromRGB(0x6cab36).CGColor;
    self.partiesIconImageView.layer.borderWidth = 2;
    // Do any additional setup after loading the view from its nib.
}
-(void)callShareservice
{
    
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionSharePost,@"action",@"partydetail",@" share_on_type",@"1",@"share_on_id ",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShare] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    
}
- (IBAction)shareOnSocialSite:(id)sender
{
    [self.btnComment setSelected:NO];
    [self.btnShare setSelected:YES];
    [self.btnShocks  setSelected:NO];
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:(id)self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"FaceBook", @"Twitter",@"WhatsApp",@"Send Mail", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [shareActionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        //[self postOnFaceBook];

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
//		[variables setObject:self.partyDescriptionTextView.text forKey:@"message"];
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
//             [self callShareservice];
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
    NSError *error = [engine postTweet:self.partyDescriptionTextView.text];
    
    if (error == nil) {
        
        NSLog(@"post succesFull");
        
        
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
    NSString *messageBody =self.partyDescriptionTextView.text ;
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
-(void)sendMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = self.partiesObj.parties_detail;
        controller.messageComposeDelegate = (id)self;
    }}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shock India" message:@"Unknown Error"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
            break;
        case MessageComposeResultSent:
            [self callShareservice];
            break;
        default:
            break;
    }
}
-(void)postOnWhatsApp
{
    if ([WhatsAppKit isWhatsAppInstalled]) {
        [WhatsAppKit launchWhatsAppWithMessage:self.partiesObj.parties_detail];
         [self callShareservice];
    }
    
}
-(void)getArray:(NSArray*)array
{
		WEPopoverContentViewController *contentViewController=[[WEPopoverContentViewController alloc]init];
        NSMutableArray *arra1y =[[NSMutableArray alloc]initWithObjects:@"hello",@"hello2", nil];
        contentViewController.dataSource=arra1y;
		self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController] ;
        CGRect frame = [buttonRef convertRect:buttonRef.bounds toView:self.view];
        frame.origin.y = 200;
    frame.size.height = [arra1y count]*44;
		[self.popoverController presentPopoverFromRect:frame
												inView:self.view
							  permittedArrowDirections:UIPopoverArrowDirectionDown
											  animated:YES];
}




- (IBAction)shockedBtnClicked:(id)sender {
    [self.btnComment setSelected:NO];
    [self.btnShare setSelected:NO];
    [self.btnShocks  setSelected:YES];
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockPost,@"action",@"partydetail",@"shock_on_type",@"1",@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(shockButtonDisable) delegate:self];
    
}

- (IBAction)commentBtnClicked:(UIButton*)button
{
    if (self.popoverController && buttonRef==button&& button.selected) {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
        return;
    }
    button.selected = !button.selected;
     buttonRef=button;
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"partydetail",@"comment_on_type",@"1",@"comment_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(getArray:) delegate:self];
    [self.btnComment setSelected:YES];
    [self.btnShare setSelected:NO];
    [self.btnShocks  setSelected:NO];
    
}
-(void)shockButtonDisable
{
    self.btnShocks.enabled=NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
