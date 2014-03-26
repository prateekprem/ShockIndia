//
//  Poll.h
//  ShockIndia
//
//  Created by NZT Solutions on 22/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Poll : NSObject
@property(nonatomic) int party_vote;
@property(nonatomic) NSString *party_name;
@property(nonatomic)int leader_Vote;
@property(nonatomic,strong)NSString *leader_name;
@end
