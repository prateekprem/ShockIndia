//
//  WhyVoteViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "WhyVoteViewController.h"
#import "FHSTwitterEngine.h"
#import "Global.h"
#import <MessageUI/MessageUI.h>
#import "StoryViewController.h"

@interface WhyVoteViewController ()

@end

@implementation WhyVoteViewController

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
    [self.messageTextView   resignFirstResponder];
    
    [self.btnWhyVote setSelected:TRUE];
    [self.btnStory setSelected:NO];
    self.btnSpreadVoice.selected = NO;
    
    self.spreadView.frame=CGRectMake(0, 120, 320, 448);
    [self.messageTextView   becomeFirstResponder];
    [self.view addSubview:self.spreadView];
    self.spreadView.hidden = TRUE;
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-200)];
    webView.scalesPageToFit = YES;
	webView.delegate=self;
	webView.opaque =NO;
	webView.backgroundColor = [UIColor clearColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"whyvote" ofType:@"rtf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    webView.hidden = TRUE;
    
    storyView=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];
    storyView.view.frame=CGRectMake(0, self.btnStory.frame.origin.y+self.btnStory.frame.size.height, 320, self.view.frame.size.height-(self.btnStory.frame.origin.y+self.btnStory.frame.size.height));
    [self.view addSubview:storyView.view];
    
    NSString *string = [NSString stringWithFormat:@"%@ is Shocking India. Join and make a difference!",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_name"]];
    self.messageTextView.text = string;
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"Xg3ACDprWAH8loEPjMzRg" andSecret:@"9LwYDxw1iTc6D9ebHdrYCZrJP4lJhQv5uf4ueiPHvJ0"];
    [[FHSTwitterEngine sharedEngine]setDelegate:(id)self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    [[Global sharedController]addTopBar:self];
    
    [self.btnStory sendActionsForControlEvents:UIControlEventTouchUpInside];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)whyVote:(id)sender
{
    [self.messageTextView   resignFirstResponder];

    webView.hidden = FALSE;
    self.spreadView.hidden = TRUE;
    storyView.view.hidden = TRUE;
    [self.btnWhyVote setSelected:TRUE];
    [self.btnStory setSelected:NO];
    self.btnSpreadVoice.selected = NO;
}

- (IBAction)story:(id)sender
{
    webView.hidden = TRUE;
    self.spreadView.hidden = TRUE;
    storyView.view.hidden = FALSE;
    [self.btnWhyVote setSelected:NO];
    [self.btnStory setSelected:TRUE];
    self.btnSpreadVoice.selected = NO;
    [self.messageTextView   resignFirstResponder];
}
- (IBAction)spreadYourVoice:(id)sender
{
    [self.btnWhyVote setSelected:NO];
    [self.btnStory setSelected:NO];
    self.btnSpreadVoice.selected = TRUE;
    [self.messageTextView   becomeFirstResponder];
    webView.hidden = TRUE;
    self.spreadView.hidden = FALSE;
    storyView.view.hidden = TRUE;
 
}
- (IBAction)postOnFacebook:(id)sender
{
//    [self postOnFaceBook];


}

- (IBAction)launchWhatsAppWithMessage:(UIButton *)sender {
    if ([WhatsAppKit isWhatsAppInstalled]) {
        [WhatsAppKit launchWhatsAppWithMessage:self.messageTextView.text];
    }
}


-(void)postOnTwitter
{
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
    }];
    [self presentViewController:loginController animated:YES completion:nil];
    
    FHSTwitterEngine *engine =  [FHSTwitterEngine sharedEngine];
    NSError *error = [engine postTweet:self.messageTextView.text];
    
    if (error == nil) {
        
        NSLog(@"post succesFull");
        
    }else{
        [error localizedDescription];
        NSLog(@"error is %@",[error localizedDescription]);

}
}
- (IBAction)sendGmail:(id)sender
{
    [self  sendMail];


}

- (IBAction)sendMessage:(id)sender
{
    [self sendMessage];
    
}

-(void)sendMail
{
    NSString *emailTitle = @"Shock India";
    // Email Content
    NSString *messageBody =self.messageTextView.text ;
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
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}


-(void)sendMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = self.messageTextView.text;
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
            
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)postOnTwitter:(id)sender {
    [self postOnTwitter];
}
@end
