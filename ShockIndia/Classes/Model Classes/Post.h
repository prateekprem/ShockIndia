//
//  Post.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (nonatomic) int post_id;
@property (nonatomic, retain) NSString * post_name;
@property (nonatomic) int discussion_id;
@property (nonatomic, retain) NSString * post_detail;
@property (nonatomic, retain) NSString * post_on;
@property (nonatomic, retain) NSString * post_by;
@end
