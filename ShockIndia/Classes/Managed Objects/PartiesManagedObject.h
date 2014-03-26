//
//  PartiesManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartiesManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * parties_id;
@property (nonatomic, retain) NSString * parties_name;
@property (nonatomic, retain) NSString * parties_short_name;
@property (nonatomic, retain) NSString * parties_detail;
@property (nonatomic, retain) NSString * parties_icon;
@property (nonatomic, retain) NSString * parties_images;
@property (nonatomic, retain) NSString * parties_fb;
@property (nonatomic, retain) NSString * parties_twitter;
@property (nonatomic, retain) NSString * parties_website;
@property (nonatomic, retain) NSString * parties_type;

@end
