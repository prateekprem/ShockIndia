//
//  VideosManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface VideosManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * video_id;
@property (nonatomic, retain) NSString * video_name;
@property (nonatomic, retain) NSString * video_detail;
@property (nonatomic, retain) NSString * video_link;
@property (nonatomic, retain) NSString * video_path;
@property (nonatomic, retain) NSString * video_shocks;
@property (nonatomic, retain) NSString * video_comments;
@property (nonatomic, retain) NSString * video_shares;
@property (nonatomic, retain) NSString * video_time;
@property (nonatomic, retain) NSString * video_posted_by;
@property (nonatomic, retain) NSString * video_thumbnail;

@end
