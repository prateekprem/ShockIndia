//
//  TermAndConditionController.m
//  ShockIndia
//
//  Created by NZT Solutions on 10/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "TermAndConditionController.h"
#import "HomeViewController.h"
#import "LoadingViewFB.h"
@interface TermAndConditionController ()

@end

@implementation TermAndConditionController

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
    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadWebView
{
    self.termAndConditionWebView.scalesPageToFit = YES;
	self.termAndConditionWebView.delegate=self;
	self.termAndConditionWebView.opaque =NO;
	self.termAndConditionWebView.backgroundColor = [UIColor clearColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"rtf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.termAndConditionWebView loadRequest:request];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIWebViewDelegate Function
- (void)webViewDidStartLoad:(UIWebView *)_webView
{
    
	[LoadingViewFB displayLoadingIndicator];
	
	
    
}
- (void)webViewDidFinishLoad:(UIWebView *)_webView {
	
	[LoadingViewFB removeLoadingIndicator];
}

@end
