//
//  UserManagedObject.h
//  ShockIndia
//
//  Created by Divya Sharma on 07/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserManagedObject : NSManagedObject

@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSString * user_phone;
@property (nonatomic, retain) NSString * user_email;
@property (nonatomic, retain) NSString * user_address;
@property (nonatomic, retain) NSString * user_age;
@property (nonatomic, retain) NSString * user_gender;
@property (nonatomic, retain) NSString * user_political_view;
@property (nonatomic, retain) NSString * user_fb_link;
@property (nonatomic, retain) NSString * user_twitter_link;
@property (nonatomic, retain) NSString * user_country;
@property (nonatomic, retain) NSString * user_photo;

@end
