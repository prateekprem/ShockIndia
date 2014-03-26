//
//  Global.h
//  MrsDash
//
//  Created by Kiwitech on 28/01/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

@interface Global : NSObject    <ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
@property (nonatomic) BOOL bannerIsVisible;
@property (nonatomic, strong, readwrite)UIViewController *viewController;
- (void)addTopBar:(UIViewController *)vwController;
+ (Global*)sharedController;
- (void)turnOnAdd:(BOOL)yes forViewController:(UIViewController *)vwController;
@end
