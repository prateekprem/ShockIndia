//
//  CampaignManagedObject.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CampaignManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * campaign_id;
@property (nonatomic, retain) NSString * campaign_name;
@property (nonatomic, retain) NSString * campaign_time;
@property (nonatomic, retain) NSString * campaign_venue;
@property (nonatomic, retain) NSString * campaign_host;
@property (nonatomic, retain) NSString * campaign_cause;
@property (nonatomic, retain) NSString * campaign_icon;
@property (nonatomic, retain) NSString * campaign_photos;
@property (nonatomic, retain) NSString * campaign_video;
@property (nonatomic, retain) NSString * campaign_strength;
@property (nonatomic, retain) NSString * campaign_detail;

@end
