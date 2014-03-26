//
//  LeadersManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LeadersManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * leaders_id;
@property (nonatomic, retain) NSString * leaders_name;
@property (nonatomic, retain) NSString * leaders_detail;
@property (nonatomic, retain) NSString * leaders_icon;
@property (nonatomic, retain) NSString * leaders_fb;
@property (nonatomic, retain) NSString * leaders_twitter;
@property (nonatomic, retain) NSString * leaders_website;
@property (nonatomic, retain) NSString * leaders_images;

@end