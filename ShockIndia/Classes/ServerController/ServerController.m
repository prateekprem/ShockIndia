//
//  ViewController.m
//  AfNetworkingSample
//
//  Created by Kiwitech on 02/01/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//
#import "Constants.h"
#import "LoadingViewFB.h"
#import "ServerController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "Story.h"
#import "Parties.h"
#import "Leaders.h"
#import "Fact.h"
#import "Question.h"
#import "DataBaseController.h"
#import "Reachability.h"
#import "Comment.h"
#import "Poll.h"
@implementation ServerController
static ServerController* _sharedServerController;
@synthesize delegate = delegate_;
@synthesize  selectorMethod = selectorMethod_;


+ (ServerController*)sharedController {
	@synchronized(self) {
        if (_sharedServerController == nil) {
            _sharedServerController=[[self alloc] init];
        }
    }
    return _sharedServerController;
}
- (BOOL)checkNetworkStatusWithAlert:(BOOL)shouldAlert {
    
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    BOOL isNetworkAvail = YES;
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            isNetworkAvail = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            isNetworkAvail = YES;
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            isNetworkAvail = YES;
            break;
        }
    }
    
    if(isNetworkAvail == NO && shouldAlert == YES) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connection!" message:@"Internet connection appears to be offline. Try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    
    return isNetworkAvail;
}
- (void)callWebServiceUploadPhotoGetJsonResponse:(NSString *)url userInfo:(NSDictionary *)userParams
{
   
  
    NSData *imageData =  [userParams objectForKey:@"data"];
    NSString *imageName =  [userParams objectForKey:@"photo"];

    NSMutableDictionary *dict = [userParams mutableCopy];
    [dict removeObjectForKey:@"photo"];
    [dict removeObjectForKey:@"data"];
    [dict removeObjectForKey:@"requestType"];
    NSLog(@"gona upload image");
    AFHTTPClient *httpClient= [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];

    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData:imageData name:@"photo" fileName:imageName mimeType:@"image/jpg"];
    }];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.userInfo = userParams;
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    NSLog(@"Sent %lld of %lld bytes",totalBytesWritten,totalBytesExpectedToWrite);
    }];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dictionaryForJsonString:operation.responseData response:operation.responseString userInfo:operation.userInfo];
        }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      
                                      [LoadingViewFB removeLoadingIndicator];
                                  }
     ];
    [httpClient enqueueHTTPRequestOperation:operation];
}


- (void)callWebServiceGetJsonResponse:(NSString *)url userInfo:(NSDictionary *)userParams  withSelector:(SEL)selector delegate:(id)delegate
{
   
    self.selectorMethod = selector;
    self.delegate = delegate;
    
    ServiceType type = [[userParams objectForKey:@"requestType"]intValue];

    if (type== FetchShock || type == FetchShare || type == FetchComment) {
        

    }
    else
    {
        if (![self checkNetworkStatusWithAlert:YES]) {
            return;
        }
        [LoadingViewFB displayLoadingIndicator];
    
    }
    if ([userParams objectForKey:@"photo"]) {
        [self callWebServiceUploadPhotoGetJsonResponse:url userInfo:userParams];
        return;
    }
    NSMutableDictionary *parameters = [userParams mutableCopy];
    [parameters removeObjectForKey:@"requestType"];
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseUrl]];
     [httpClient defaultValueForHeader:@"Accept"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:url parameters:parameters];
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.userInfo = userParams;
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [httpClient.operationQueue waitUntilAllOperationsAreFinished];
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dictionaryForJsonString:operation.responseData response:operation.responseString userInfo:operation.userInfo];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [LoadingViewFB removeLoadingIndicator];
    }
     ];
    [operation start];
    
}
#pragma mark call services


- (void)dictionaryForJsonString:(NSData *)data response:(NSString *)response userInfo:(NSDictionary *)dict
{
    [LoadingViewFB removeLoadingIndicator];

    NSError *error = nil;
    ServiceType type = [[dict objectForKey:@"requestType"]intValue];
   id response_dict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    NSLog(@"Response Data == > %@",response_dict);
    NSLog(@"Response String == > %@",response);
    
    
    if ([response isEqualToString:@"[]"]) {
        
        return;
    }
//    else if ([response isEqualToString:@"email id is available"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Shock India" message:@"User already registered with us." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    NSArray *array;
    switch (type)
    {
        case SignUp:
        {
            [self getUserResponse:response_dict];
        }
            break;
        case FetchStory:
        {
           [self getStoryResponse:response_dict];
        }
            break;
        case FetchFact:
        {
            [self getFactResponse:response_dict];
        }
            break;
        case FetchLeader:
        {
            [self getLeaderResponse:response_dict];
        }
            break;
        case FetchParty:
        {
            [self getPartyResponse:response_dict];
        }
            break;
        case FetchQuiz:
        {
            array = [self getQuizResponse:response_dict];
        }
            break;
        case FetchComment:
        {
            array=[self getCommentResponse:response_dict];
        
        }
        case FetchShare:
        {
            array=[self getShareResponse:response_dict];
            
        }
        case FetchShock:
        {
            array=[self getShockResponse:response_dict];
            
        }
        case FetchPoll:
        {
            array=[self getOpinionResponse:response_dict];
            
        }
        case PostShock:
        {
            array=[self getPostShockResponse:response_dict];
            
        }
        case PostComment:
        {
            array=[self getPostShareResponse:response_dict];
            
        }
        case PostShare:
        {
            array=[self getPostCommentResponse:response_dict];
            
        }
        default:
            break;
    }
    [delegate_ performSelector:self.selectorMethod withObject:array];
    if (type!= FetchShock && type != FetchShock && type != FetchComment) {
    [LoadingViewFB removeLoadingIndicator];
    }
}

- (NSArray *)getQuizResponse:(NSArray *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"question_detail"];
        NSDictionary *inner_dict1 = [[dict objectAtIndex:i]objectForKey:@"option_detail"];

         Question*obj = [[Question alloc]init];
        obj.question_name = [inner_dict objectForKey:@"question_description"];
        obj.option1 = [inner_dict1 objectForKey:@"option1"];
        obj.option2 = [inner_dict1 objectForKey:@"option2"];
        obj.option3 = [inner_dict1 objectForKey:@"option3"];
        obj.correctOption = [inner_dict1 objectForKey:@"answer"];
        [array addObject:obj];
    }
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getShockResponse:(NSDictionary *)dict
{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if ([dict objectForKey:@"shock_detail"]) {
        [array addObject:[dict objectForKey:@"shock_detail"]];
        
    }
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getCommentResponse:(NSArray *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"comment_detail"];
        NSDictionary *inner_dict1 = [[dict objectAtIndex:i]objectForKey:@"user_detail"];
        
        Comment*obj = [[Comment alloc]init];
        obj.comment_detail = [inner_dict objectForKey:@"comment"];
        obj.comment_by = [inner_dict1 objectForKey:@"name"];
        
        [array addObject:obj];
    }
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getShareResponse:(NSDictionary *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if ([dict objectForKey:@"share_detail"]) {

    [array addObject:[dict objectForKey:@"share_detail"]];
    }
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getOpinionResponse:(NSDictionary *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getPostShockResponse:(NSDictionary *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getPostShareResponse:(NSDictionary *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    return [NSArray arrayWithArray:array];
}
- (NSArray *)getPostCommentResponse:(NSDictionary *)dict
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    return [NSArray arrayWithArray:array];
}

- (NSString*)stripTags:(NSString *)str
{
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"(" intoString:&tempText];
                
        [scanner scanUpToString:@")" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
       
    }
    
    
    return tempText;
}
- (void)getPartyResponse:(NSArray *)dict
{
    
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"party_detail"];
        Parties *obj = [[Parties alloc]init];
        obj.parties_id = [[inner_dict objectForKey:@"party_id"]integerValue];
        obj.parties_name = [self stripTags:[inner_dict objectForKey:@"party_name"]];
        obj.parties_short_name = [[inner_dict objectForKey:@"party_name"] stringByReplacingOccurrencesOfString:obj.parties_name withString:@""];
        obj.parties_short_name = [obj.parties_short_name stringByReplacingOccurrencesOfString:@"(" withString:@""];
         obj.parties_short_name = [obj.parties_short_name stringByReplacingOccurrencesOfString:@")" withString:@""];
        obj.parties_fb = [inner_dict objectForKey:@"party_fb_link"];
        obj.parties_twitter = [inner_dict objectForKey:@"party_twitter_link"];
        obj.parties_website = [inner_dict objectForKey:@"party_web_link"];
        obj.parties_detail = [inner_dict objectForKey:@"party_description"];
        obj.parties_icon= [inner_dict objectForKey:@"small_image"];
        obj.parties_images= [inner_dict objectForKey:@"large_image"];
        obj.parties_type =[inner_dict objectForKey:@"party_type"];
        [[DataBaseController sharedController]insertingDataIntoPartiesTable:obj];
    }
}
- (void)getLeaderResponse:(NSArray *)dict
{
    
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"leader_detail"];
        Leaders *obj = [[Leaders alloc]init];
        obj.leaders_id = [[inner_dict objectForKey:@"leader_id"]integerValue];
        obj.leaders_name = [inner_dict objectForKey:@"name"];
        obj.leaders_fb = [inner_dict objectForKey:@"fblink"];
        obj.leaders_twitter = [inner_dict objectForKey:@"twitterlink"];
        obj.leaders_website = [inner_dict objectForKey:@"weblink"];
        obj.leaders_icon = [inner_dict objectForKey:@"small_image"];
        obj.leaders_detail= [inner_dict objectForKey:@"description"];
        obj.leaders_images = [inner_dict objectForKey:@"large_image"];

        [[DataBaseController sharedController]insertingDataIntoLeaderTable:obj];
    }
}
- (void)getStoryResponse:(NSArray *)dict
{
    
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"story_detail"];
        NSDictionary *inner_dict1 = [inner_dict objectForKey:@"user_detail"];

        Story *story = [[Story alloc]init];
        story.story_id = [[inner_dict objectForKey:@"story_id"]integerValue];
        story.story_name = [inner_dict objectForKey:@"story_name"];
        story.story_detail = [inner_dict objectForKey:@"story_detail"];
        story.story_posted_by = [inner_dict objectForKey:@"story_by"];
        story.story_pic = [inner_dict1 objectForKey:@"photo"];
        story.story_posted_on = [inner_dict objectForKey:@"datetime"];
        story.story_shares= [inner_dict objectForKey:@"story_shares"];
        story.story_shocks= [inner_dict objectForKey:@"story_shocks"];
        story.story_comments= [inner_dict objectForKey:@"story_comments"];
        story.story_video_link= [inner_dict objectForKey:@"video"];
        [[DataBaseController sharedController]insertingDataIntoStoryTable:story];
    }
}
- (void)getFactResponse:(NSArray *)dict
{
    
    for (int i=0; i<[dict count]; i++) {
        NSDictionary *inner_dict1 = [[dict objectAtIndex:i]objectForKey:@"fact_detail"];
        NSDictionary *inner_dict = [[dict objectAtIndex:i]objectForKey:@"user_detail"];
            Fact *fact = [[Fact alloc]init];
            fact.fact_id = [[inner_dict1 objectForKey:@"fact_id"]integerValue];
            fact.fact_name = [inner_dict1 objectForKey:@"fact_name"];
            fact.fact_detail = [inner_dict1 objectForKey:@"fact_detail"];
            fact.fact_posted_by = [inner_dict1 objectForKey:@"fact_posted_by"];
            fact.fact_pics = [inner_dict objectForKey:@"photo"];
            fact.fact_posted_on = [inner_dict1 objectForKey:@"datetime"];
            fact.fact_shares= [inner_dict1 objectForKey:@"fact_shares"];
            fact.fact_shocks= [inner_dict1 objectForKey:@"fact_shocks"];
            fact.fact_comments= [inner_dict1 objectForKey:@"fact_comments"];
            fact.fact_video_link= [inner_dict1 objectForKey:@"video"];

        [[DataBaseController sharedController]insertingDataIntoFactTable:fact];
    }

}
- (void)getUserResponse:(NSDictionary *)dict
{

    if ([dict objectForKey:@"user_id"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"user_id"] forKey:@"user_id"];
    }
}

@end
