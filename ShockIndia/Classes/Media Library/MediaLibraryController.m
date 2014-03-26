//
//  MediaLibraryController.m
//  ShockIndia
//
//  Created by NZT Solutions on 06/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "MediaLibraryController.h"
#import "SWRevealViewController.h"

@interface MediaLibraryController ()

@end

@implementation MediaLibraryController

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

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end