//
//  QuizManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QuizManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * quiz_id;
@property (nonatomic, retain) NSString * quiz_name;
@property (nonatomic, retain) NSNumber * quiz_no_of_questions;
@property (nonatomic, retain) NSString * quiz_posted_by;
@property (nonatomic, retain) NSString * quiz_posted_on;
@property (nonatomic, retain) NSString * quiz_photos;

@end
