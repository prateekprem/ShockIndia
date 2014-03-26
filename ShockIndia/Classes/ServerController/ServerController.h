//
//  ViewController.h
//  AfNetworkingSample
//
//  Created by Kiwitech on 02/01/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServerProtocol <NSObject>
- (void)requestFinished:(NSDictionary *)dictionary;
@end
@interface ServerController : NSObject <NSXMLParserDelegate>
+ (ServerController*)sharedController ;
@property (nonatomic, strong) id<ServerProtocol> delegate;
@property (nonatomic) SEL selectorMethod;
- (void)callWebServiceGetJsonResponse:(NSString *)url userInfo:(NSDictionary *)userParams withSelector:(SEL)selector delegate:(id)delegate;
- (void)callWebServiceUploadPhotoGetJsonResponse:(NSString *)url userInfo:(NSDictionary *)userParams;
- (void)dictionaryForJsonString:(NSData *)data response:(NSString *)response userInfo:(NSDictionary *)dict;
- (void)getStoryResponse:(NSArray *)dict;
- (void)getUserResponse:(NSArray *)dict;
- (void)getLeaderResponse:(NSArray *)dict;
- (void)getFactResponse:(NSArray *)dict;
- (NSArray *)getQuizResponse:(NSArray *)dict;
@end
