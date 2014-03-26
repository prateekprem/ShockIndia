//
//  AboutUsViewController.m
//  ShockIndia
//
//  Created by NZT Solutions on 06/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize webView = webView_;
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about_us" ofType:@"rtf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
