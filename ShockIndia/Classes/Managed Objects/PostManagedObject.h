//
//  PostManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PostManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * post_id;
@property (nonatomic, retain) NSString * post_name;
@property (nonatomic, retain) NSNumber * discussion_id;
@property (nonatomic, retain) NSString * post_detail;
@property (nonatomic, retain) NSString * post_on;
@property (nonatomic, retain) NSString * post_by;

@end
