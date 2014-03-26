//
//  AppDelegate.m
//  ShockIndia
//
//  Created by Divya Sharma on 01/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "SWRevealViewController.h"
#import "FactViewController.h"
#import "ContentViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
@interface AppDelegate()<SWRevealViewControllerDelegate>
@end


@implementation AppDelegate
@synthesize managedObjectContext        = _managedObjectContext;
@synthesize managedObjectModel          = _managedObjectModel;
@synthesize persistentStoreCoordinator  = _persistentStoreCoordinator;
@synthesize user_id = user_id_;
@synthesize points = points_;
AppDelegate *appDelegate;
- (void)callWebService
{
//
    
    
//       NSMutableDictionary *dict5 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionFactGet,@"action", nil];
//        [dict5 setObject:[NSString stringWithFormat:@"%d",FetchFact] forKey:@"requestType"];
//        [[ServerController sharedController]callWebServiceGetJsonResponse:kFactUrl userInfo:dict5 withSelector:Nil delegate:Nil];
    
//       NSMutableDictionary *dict3 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionStoryGet,@"action", nil];
//        [dict3 setObject:[NSString stringWithFormat:@"%d",FetchStory] forKey:@"requestType"];
//        [[ServerController sharedController]callWebServiceGetJsonResponse:kStoryUrl userInfo:dict3 withSelector:Nil delegate:Nil];
//    
    
    //
//     NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionPartyGet,@"action", nil];
//    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchParty] forKey:@"requestType"];
//        [[ServerController sharedController]callWebServiceGetJsonResponse:kPartyUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    //
    //     NSMutableDictionary *dict6 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionLeaderGet,@"action", nil];
    //        [dict6 setObject:[NSString stringWithFormat:@"%d",FetchLeader] forKey:@"requestType"];
    //        [[ServerController sharedController]callWebServiceGetJsonResponse:kLeaderUrl userInfo:dict6 withSelector:Nil delegate:Nil];
    
    //    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"get_shock",@"action",@"story",@"shock_on_type",@"1",@"shock_on_id",nil];
    //    [[ServerController sharedController]callWebServiceGetJsonResponse:@"shock.php" userInfo:dict1 withSelector:Nil delegate:Nil];
    
    //    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockPost,@"action",@"fact",@"shock_on_type",@"3",@"shock_on_id",nil];
    //    [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShock] forKey:@"requestType"];
    //    [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    //      NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionShockGet,@"action",@"fact",@"shock_on_type",@"3",@"shock_on_id",nil];
    //           [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShock] forKey:@"requestType"];
    //            [[ServerController sharedController]callWebServiceGetJsonResponse:kShockUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    //        NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionSharePost,@"action",@"fact",@" share_on_type",@"1",@"share_on_id ",nil];
    //        [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShare] forKey:@"requestType"];
    //        [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    //        NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionshareGet,@"action",@"fact",@" share_on_type",@"1",@"share_on_id ",nil];
    //            [dict1 setObject:[NSString stringWithFormat:@"%d",FetchShare] forKey:@"requestType"];
    //            [[ServerController sharedController]callWebServiceGetJsonResponse:kShareUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    
    //       NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentPost,@"action",@"1",@"user_id",@"hi",@"comment",@"19/3/14",@"date",@"fact",@"comment_on_type",@"1",@"comment_on_id",nil];
    //           [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    //            [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    //        NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentGet,@"action",@"fact",@"comment_on_type",@"1",@"comment_on_id",nil];
    //              [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    //                [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:Nil delegate:Nil];
    //        NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionCommentPost,@"action",@"1",@"user_id",@"hi",@"comment",@"19/3/14",@"date",@"story",@"comment_on_type",@"1",@"comment_on_id",nil];
    //           [dict1 setObject:[NSString stringWithFormat:@"%d",FetchComment] forKey:@"requestType"];
    //            [[ServerController sharedController]callWebServiceGetJsonResponse:kCommentUrl userInfo:dict1 withSelector:Nil delegate:Nil];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self callWebService];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"launch"];
    [Parse setApplicationId:@"Tvmf1ze6IhGCAMSqXofbl30yFoR4ZtlAB6gdMMZM"
                  clientKey:@"e1WLb3EX7MhUTw9aRV1UxTQWtW9sr9VWqjPVNYxJ"];
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
   // [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)];
    
    // Uncomment to change the color of back button
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Uncomment to assign a custom backgroung image
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Uncomment to change the back indicator image
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
    
    
    // Uncomment to change the font style of the title
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor orangeColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue" size:21.0], NSFontAttributeName, nil]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    appDelegate = self;
    ContentViewController *contetView =[[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
    UINavigationController *contentNav = [[UINavigationController alloc]  initWithRootViewController:contetView];
    SWRevealViewController *revealView;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]) {
        HomeViewController *homeView;
        if (IS_IPHONE_5) {
            homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController1" bundle:nil];
        }
        else{
            homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                   }
        UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:homeView];
        revealView=[[SWRevealViewController alloc]initWithRearViewController:contentNav frontViewController:nav];
        nav.navigationBar.hidden = YES;
    }
    else
    {
        SignUpViewController *signUp=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:signUp];
        revealView=[[SWRevealViewController alloc]initWithRearViewController:contentNav frontViewController:nav];
        nav.navigationBar.hidden = YES;
    
    }
    
    revealView.delegate=self;
    revealView.rightViewController=contentNav;
    
    self.viewController=revealView;
    [self managedObjectContext];
    [[DataBaseController sharedController] allocatingObjectContext];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
    
    
    
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeftSideMostRemoved ) str = @"FrontViewPositionLeftSideMostRemoved";
    if ( position == FrontViewPositionLeftSideMost) str = @"FrontViewPositionLeftSideMost";
    if ( position == FrontViewPositionLeftSide) str = @"FrontViewPositionLeftSide";
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
}

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}

- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress
{
    NSLog( @"%@: %f, %f", NSStringFromSelector(_cmd), location, progress);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [FBAppEvents activateApp];
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
  }

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.session close];

    [self saveContext];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ShockIndiaModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationCacheDirectory] URLByAppendingPathComponent:@"ShockIndia.sqlite"];
    
    NSError *error = nil;
    
    
    [self copyDatabaseToCache:YES];
    
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:^(FBAppCall *call) {
                                      NSLog(@"Unhandled deep link: %@", url);
                                      // Here goes the code to handle the links
                                      // Use the links to show a relevant view of your app to the user
                                  }];
    
    return urlWasHandled;
}
- (void)copyDatabaseToCache:(BOOL)isZipedData
{
    if (!isZipedData) {
        return;
    }
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
    NSString *dbPath1 = [documentFolderPath stringByAppendingPathComponent:@"ShockIndia.sqlite"];
    NSString *backupDbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ShockIndia.sqlite"];
    
    
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:dbPath1]) {
        [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbPath1 error:nil];
    }
    
    
}
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationCacheDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
