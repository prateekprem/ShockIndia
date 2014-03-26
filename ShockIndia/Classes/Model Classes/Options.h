//
//  Options.h
//  ShockIndia
//
//  Created by NZT Solutions on 08/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Options : NSObject
@property (nonatomic) int option_id;
@property (nonatomic) int question_id;
@property (nonatomic, retain) NSString * option_name;
@property (nonatomic, retain) NSString * is_answer;
@property (nonatomic, retain) NSString * option_photo;
@end
