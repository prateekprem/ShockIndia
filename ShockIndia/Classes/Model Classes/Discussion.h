//
//  Discussion.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Discussion : NSObject
@property (nonatomic) int discussion_id;
@property (nonatomic, retain) NSString * discussion_topic;
@property (nonatomic, retain) NSString * discussion_detail;
@property (nonatomic, retain) NSString * discussion_users;
@property (nonatomic, retain) NSString * discussion_icon;
@property (nonatomic, retain) NSString * discussion_by;
@property (nonatomic, retain) NSString * discussion_created_on;

@end
