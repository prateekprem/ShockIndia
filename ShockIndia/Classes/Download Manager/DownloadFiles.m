//
//  DownloadFiles.m
//  
//
//  Created by Ishu on 29/03/11.
//  Copyright 2011 Kiwitech. All rights reserved.
//
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "DownloadFiles.h"
#import "ZipArchive.h"
#import "Reachability.h"
#import "DownloadController.h"
#import "AFHTTPRequestOperation.h"
@implementation DownloadFiles
@synthesize filePath;
@synthesize fileDocPath;
@synthesize callBackTarget;
@synthesize callBackSelector;
@synthesize isZip = isZip_;
double totalexpectedData;


NSURLConnection *connection;
NSString *serverUrl;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)startDownload:(NSString *)fileURL withOffset:(int)offset {
    if (![self checkNetworkStatus]) {
        return;
    }
    
	serverUrl=[fileURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSURL *url=[NSURL URLWithString:serverUrl];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	        
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
   
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:nil];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // do something with the data
       // if (isZip_) {
            ZipArchive *za = [[ZipArchive alloc] init];
            if ([za UnzipOpenFile: filePath]) {
                BOOL ret = [za UnzipFileTo:fileDocPath overWrite: YES];
                if (NO == ret){} [za UnzipCloseFile];
            }
            NSFileManager *filemanager=[NSFileManager defaultManager];
            NSError *error;
            if([filemanager fileExistsAtPath:filePath])
                [filemanager removeItemAtPath:filePath error:&error];
        //}
        connection = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSUserDefaults standardUserDefaults] setObject:@"TRUE" forKey:serverUrl];
        SuppressPerformSelectorLeakWarning(
        [(DownloadController *)self.callBackTarget performSelector:self.callBackSelector];
        );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DownloadController *downloadController=[DownloadController sharedController];
        [downloadController forceCloseDownloading];
    }];
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:myTimer forMode:NSRunLoopCommonModes];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
    {
        float progress = (float)totalBytesRead / totalBytesExpectedToRead;
        DownloadController *downloadHandler=[DownloadController sharedController];
    	[downloadHandler appendNewDataWithDownloadedData:progress];
    }];

    [operation start];
	
}

- (void)updateProgress:(NSTimer *)timer
{

}
-(void)cancelDownloading
{
	if(connection)
        [connection cancel];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark ------------ Netwok Status Method -----------------
- (BOOL)checkNetworkStatus
{
    BOOL isNetworkAvail_;
    NetworkStatus internetStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            isNetworkAvail_ = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            isNetworkAvail_ = YES;
            break;
            
        }
        case ReachableViaWWAN:
        {
            isNetworkAvail_ = YES;
            break;
        }
    }
    if (!isNetworkAvail_) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"No internet connection!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    return isNetworkAvail_;
}
@end
