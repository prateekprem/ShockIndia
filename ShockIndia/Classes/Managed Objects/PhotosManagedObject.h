//
//  PhotosManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhotosManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * photo_id;
@property (nonatomic, retain) NSString * photo_name;
@property (nonatomic, retain) NSString * photo_detail;
@property (nonatomic, retain) NSString * photo_link;
@property (nonatomic, retain) NSString * photo_path;
@property (nonatomic, retain) NSString * photo_shocks;
@property (nonatomic, retain) NSString * photo_comments;
@property (nonatomic, retain) NSString * photo_shares;
@property (nonatomic, retain) NSString * photo_time;
@property (nonatomic, retain) NSString * photo_posted_by;

@end
