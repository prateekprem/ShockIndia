//
//  StoryViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "StoryViewController.h"
#import "ServerController.h"
#import "StoryCell.h"
#import "PartyCell.h"
#import "Story.h"
#import "StoryView.h"
#import "AnimateViews.h"
#import "FHSTwitterEngine.h"
#import <MessageUI/MessageUI.h>
#define kHeight 129
#import "Constants.h"
#define kStory @"story"
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"



@interface StoryViewController ()
- (void)getStoryWebService;
- (void)getResponse;
@end

@implementation StoryViewController
@synthesize dataSource = dataSource_;
@synthesize storyObj = storyObj_;
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
    //[self getStoryWebService];
   // self.fbGraph= [[FbGraph alloc] initWithFbClientID:_APP_KEY];
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"6Ekn7NBQo9rwD8ixQtMmw" andSecret:@"CPdko9W0pChPJmSAT92jKNRrHfWRXHFpIPjcGkhtM"];
    [[FHSTwitterEngine sharedEngine]setDelegate:(id)self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];

    self.dataSource = [[[DataBaseController sharedController]getStoryData]mutableCopy];
    
    [self.storyTableView reloadData];
    //self.navigationController.navigationBar.hidden=NO;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getStoryWebService
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionStoryGet,@"action", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",FetchStory] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kStoryUrl userInfo:dict withSelector:nil delegate:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"row%ld",(long)indexPath.row];
    StoryCell *storyCell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Story *story = [self.dataSource objectAtIndex:indexPath.row];
    storyObj_ = story;
    if (storyCell==nil) {
      storyCell = [[StoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier datasource:story];
        storyCell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        storyCell.layer.borderWidth = 1;

    }
    storyCell.btnShare.tag = indexPath.row;
    [storyCell.btnShare  addTarget:self action:@selector(buttonTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
    
//    storyCell.btnShock.tag=indexPath.row;
//    [storyCell.btnShock  addTarget:self action:@selector(shockButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    storyCell.btnComment.tag=indexPath.row;
    [storyCell.btnComment  addTarget:self action:@selector(commentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    buttonRef.tag =storyCell.btnShare.tag;
      NSLog(@"tag is %d",buttonRef.tag);
   // NSLog(@"tag is %d",indexPath.row);

    return storyCell;
    
}
- (void)getShocks:(NSString *)story_id
{
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockGet,@"action",@"story",@"shock_on_type",story_id,@"shock_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShock] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:@selector(getNoOfShocks:) delegate:self];
    
    
}

- (void)getNoOfShocks:(NSArray *)shocks
{
    if (![shocks count]) {
        return;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight;
}
- (IBAction)submitNewStory:(id)sender {
    
    StoryView *storyView =  [[StoryView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
    storyView.delegate = (id)self;
    [appDelegate.window addSubview:storyView];
    [[AnimateViews allocate] startAnimationOnview:storyView toView:nil animationType:BounceViewAnimationType animationSubType:0];
}
- (void)getResponse
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Shock india will review your story. And notify you about it's status soon!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)buttonTappedOnCell:(UIButton*)button
{
    self.storyObj = [self.dataSource objectAtIndex:button.tag];
    buttonRef.tag= button.tag;
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"FaceBook", @"Twitter",@"WhatsApp",@"Send Mail", nil];
    shareActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [shareActionSheet showInView:self.view];

    
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
- (IBAction)commentButtonTapped:(UIButton*)button
{
buttonRef=button;
   NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"story",@"comment_on_type",button.tag,@"comment_on_id",nil];
                 [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
                    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(getArray:) delegate:self];
    
//    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentPost,@"action",@"1",@"user_id",@"hi",@"comment",@"19/3/2014",@"date",@"fact",@"comment_on_type",@"1",@"comment_on_id",nil];
//    [dict1 setObject:[NSString stringWithFormat:@"%d",PostComment] forKey:@"requestType"];
//    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(commentButtonDisable) delegate:self];
   
    
    
}



- (IBAction)shareOnSocialSite:(id)sender
{
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
-(void)postOnFaceBook
{
    // Check if the Facebook app is installed and we can present the share dialog
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"https://shockindia.co.in"];
    params.name = @"Shock India";
    params.caption = @"Build great social apps and get more installs.";
    params.picture = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"logo.png" ofType:nil]];
    params.description = self.storyObj.story_detail;
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        [FBDialogs presentShareDialogWithLink:params.link
                                         name:params.name
                                      caption:params.caption
                                  description:params.description
                                      picture:params.picture
                                  clientState:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"error %@",[NSString stringWithFormat:@"%@", error.description]);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        // Present the share dialog
    } else {
        
        // Present the feed dialog
    }
}
-(void)postOnTwitter
{
    
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
    }];
    [self presentViewController:loginController animated:YES completion:nil];
    
    FHSTwitterEngine *engine =  [FHSTwitterEngine sharedEngine];
    NSError *error = [engine postTweet:self.storyObj.story_name];
    if (error == nil) {

        NSLog(@"post succesFull");
        [self callShareservice];

        
    }else{
       // [self performSelector:@selector(callShareservice) withObject:nil afterDelay:5];

        [error localizedDescription];
        NSLog(@"error is %@",[error localizedDescription]);
               }
}

 -(void)callShareservice
{
    NSLog(@"tag is %d",buttonRef.tag);
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionSharePost,@"action",kStory,@" share_on_type",  buttonRef.tag,@"share_on_id ",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShare] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];


}
-(void)sendMail
{
    // Email Content
    NSString *messageBody =self.storyObj.story_detail ;
    // To addres
  
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
  
    mc.mailComposeDelegate = (id)self;
    [mc setSubject:@"Shock India"];
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
        [WhatsAppKit launchWhatsAppWithMessage:self.storyObj.story_detail];
           [self callShareservice];
    }
    
}




- (void)submitStory:(NSString *)storyName storyDetail:(NSString *)story_detail
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:[NSDate date]];
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionStoryAdd,@"action",storyName,@"story_name",story_detail,@"story_detail",dateString,@"datetime",kLanguage,@"language",user_id,@"user_id", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",AddStory] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kStoryUrl userInfo:dict withSelector:@selector(getResponse) delegate:self];
   
}
@end
