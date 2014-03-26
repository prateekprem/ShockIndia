//
//  Quiz.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quiz : NSObject
@property (nonatomic) int quiz_id;
@property (nonatomic, retain) NSString * quiz_name;
@property (nonatomic) int quiz_no_of_questions;
@property (nonatomic, retain) NSString * quiz_posted_by;
@property (nonatomic, retain) NSString * quiz_posted_on;
@property (nonatomic, retain) NSString * quiz_photos;
@end
