//
//  AppDelegate.h
//  ShockIndia
//
//  Created by Divya Sharma on 01/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWRevealViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *points;
@property (strong, nonatomic) FBSession *session;

- (void)saveContext;
- (void)copyDatabaseToCache:(BOOL)isZipedData;
- (NSURL *)applicationCacheDirectory;
extern AppDelegate *appDelegate;

@end
