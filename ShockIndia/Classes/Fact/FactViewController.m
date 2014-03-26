//
//  FactViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "FactViewController.h"
#import "Global.h"
#import "FactCell.h"
#import "Fact.h"
#import "FactView.h"
#import "AnimateViews.h"
#define kHeight 172;
#import "FHSTwitterEngine.h"
#import <MessageUI/MessageUI.h>
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"
@interface FactViewController ()
- (void)getResponse;
- (void)getFactWebService;
@end

@implementation FactViewController
@synthesize dataSource = dataSource_;
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
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7){
        factTable.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    }
    [[Global sharedController]addTopBar:self];
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"Xg3ACDprWAH8loEPjMzRg" andSecret:@"9LwYDxw1iTc6D9ebHdrYCZrJP4lJhQv5uf4ueiPHvJ0"];
    [[FHSTwitterEngine sharedEngine]setDelegate:(id)self];
    [[FHSTwitterEngine sharedEngine]loadAccessToken];
    self.dataSource = [[[DataBaseController sharedController]getFactData]mutableCopy];
    [factTable reloadData];
   // [self callFactWebService];
    // Do any additional setup after loading the view from its nib.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"row%ld",(long)indexPath.row];
    FactCell* factCell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (factCell==nil) {
            factCell = [[FactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            factCell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            factCell.layer.borderWidth = 1;
        }
    

    Fact *fact = [self.dataSource objectAtIndex:indexPath.row];
    factCell.textView.text = fact.fact_detail;
    if (![fact.fact_posted_by length]) {
        fact.fact_posted_by = @"Shock India";
    }
    factCell.byLabel.text = fact.fact_posted_by;
    factCell.btnShare.tag = indexPath.row;
    [factCell.btnShare  addTarget:self action:@selector(buttonTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
    [factCell.btnComment  addTarget:self action:@selector(commentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return factCell;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFactsArray:(NSArray *)array
{


}
- (void)getFactWebService
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionFactGet,@"action",@"2014-03-08",@"date",@"3",@"user_id", nil];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kFactUrl userInfo:dict withSelector:nil delegate:self];
}
- (IBAction)submit:(id)sender {
    
    FactView *storyView =  [[FactView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.superview.frame.size.height)];
    storyView.delegate = (id)self;
    [appDelegate.window addSubview:storyView];
    [[AnimateViews allocate] startAnimationOnview:storyView toView:nil animationType:BounceViewAnimationType animationSubType:0];
}
- (void)getResponse
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Shock india will review your fact. And notify you about it's status soon!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)submitFact:(NSString *)name factDetail:(NSString *)detail
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:[NSDate date]];
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionFactAdd,@"action",name,@"fact_name",detail,@"fact_detail",dateString,@"datetime",kLanguage,@"language",user_id,@"user_id", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",AddFact] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kFactUrl userInfo:dict withSelector:@selector(getResponse) delegate:self];
  
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
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"fact",@"comment_on_type",button.tag,@"comment_on_id",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(getArray:) delegate:self];
    
    //    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentPost,@"action",@"1",@"user_id",@"hi",@"comment",@"19/3/2014",@"date",@"fact",@"comment_on_type",@"1",@"comment_on_id",nil];
    //    [dict1 setObject:[NSString stringWithFormat:@"%d",PostComment] forKey:@"requestType"];
    //    [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:@selector(commentButtonDisable) delegate:self];
    
    
    
}
- (void)buttonTappedOnCell:(UIButton*)button
{
    factObj = [self.dataSource objectAtIndex:button.tag];
    
    
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel " destructiveButtonTitle:nil otherButtonTitles:@"FaceBook", @"Twitter",@"WhatsApp",@"Send Mail", nil];
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
//    [self.fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins,email,user_location,read_stream,share_item,status_update" andSuperView:self.view];
//    
//}
//- (void)fbGraphCallback:(id)sender {
//	
//	if ( (self.fbGraph.accessToken == nil) || ([self.fbGraph.accessToken length] == 0) ) {
//		
//		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
//		
//		//restart the authentication process.....
//        
//        [self.fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins,email,user_location,read_stream,share_item,status_update" andSuperView:self.view];
//		
//	}
//	else
//	{
//		
//        NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
//		
//		[variables setObject:factObj.fact_detail forKey:@"message"];
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
//            [self callShareservice];
//		}
//	}
//	
//}
-(void)callShareservice
{

    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionSharePost,@"action",@"fact",@" share_on_type",buttonRef.tag,@"share_on_id ",nil];
    [dict1 setObject:[NSString stringWithFormat:@"%d",PostShare] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    
}
-(void)postOnTwitter
{
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
    }];
    [self presentViewController:loginController animated:YES completion:nil];
    
    FHSTwitterEngine *engine =  [FHSTwitterEngine sharedEngine];
    NSError *error = [engine postTweet:factObj.fact_detail];
    
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
    NSString *messageBody =factObj.fact_detail ;
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
        [WhatsAppKit launchWhatsAppWithMessage:factObj.fact_detail];
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
