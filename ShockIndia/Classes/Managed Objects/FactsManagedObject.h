//
//  FactsManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FactsManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * fact_id;
@property (nonatomic, retain) NSString * fact_name;
@property (nonatomic, retain) NSString * fact_detail;
@property (nonatomic, retain) NSString * fact_pics;
@property (nonatomic, retain) NSString * fact_posted_by;
@property (nonatomic, retain) NSString * fact_posted_on;
@property (nonatomic, retain) NSString * fact_shocks;
@property (nonatomic, retain) NSString * fact_comments;
@property (nonatomic, retain) NSString * fact_shares;
@property (nonatomic, retain) NSString * fact_video_link;

@end
