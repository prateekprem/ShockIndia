//
//  QuestionsManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 07/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QuestionsManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * question_id;
@property (nonatomic, retain) NSNumber * quiz_id;
@property (nonatomic, retain) NSString * question_name;
@property (nonatomic, retain) NSString * question_photo;

@end
