//
//  OptionsManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OptionsManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * option_id;
@property (nonatomic, retain) NSNumber * question_id;
@property (nonatomic, retain) NSString * option_name;
@property (nonatomic, retain) NSString * is_answer;
@property (nonatomic, retain) NSString * option_photo;

@end