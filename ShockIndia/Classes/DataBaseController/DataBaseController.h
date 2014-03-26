//
//  DataBaseController.h
//  MrsDash
//
//  Created by shahnwaz on 1/17/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataBaseController;
@class UserManagedObject;
@class User;
@class Story;
@class Parties;
@class Leaders;
@class Fact;
@interface DataBaseController : NSObject

+ (DataBaseController*)sharedController ;
-(void)allocatingObjectContext;
- (User *)getMyProfileData;
-(void)insertingDataIntoStoryTable:(Story*)story;
-(void)insertingDataIntoPartiesTable:(Parties*)parties;
- (NSArray *)getStoryData;
- (NSArray *)getPartiesData;
- (NSArray *)getLeadersData;
- (NSArray *)getFactData;
-(void)insertingDataIntoLeaderTable:(Leaders*)leader;
-(void)insertingDataIntoMyProfileTable:(User *)user;
-(void)insertingDataIntoFactTable:(Fact*)fact;
@end
