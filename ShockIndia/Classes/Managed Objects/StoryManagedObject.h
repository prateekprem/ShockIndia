//
//  StoryManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 07/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StoryManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * story_id;
@property (nonatomic, retain) NSString * story_name;
@property (nonatomic, retain) NSString * story_detail;
@property (nonatomic, retain) NSString * story_pic;
@property (nonatomic, retain) NSString * story_posted_by;
@property (nonatomic, retain) NSString * story_posted_on;
@property (nonatomic, retain) NSString * story_shocks;
@property (nonatomic, retain) NSString * story_comments;
@property (nonatomic, retain) NSString * story_shares;
@property (nonatomic, retain) NSString * story_video_link;

@end
