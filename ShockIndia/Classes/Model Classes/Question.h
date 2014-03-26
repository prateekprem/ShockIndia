//
//  Question.h
//  ShockIndia
//
//  Created by NZT Solutions on 07/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic) int question_id;
@property (nonatomic) int  quiz_id;
@property (nonatomic, retain) NSString * question_name;
@property (nonatomic, retain) NSString * question_photo;
@property (nonatomic, retain) NSString * option1;
@property (nonatomic, retain) NSString * option2;
@property (nonatomic, retain) NSString * option3;
@property (nonatomic, retain) NSString * correctOption;

@end
