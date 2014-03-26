//
//  DownloadFiles.h
//  
//
//  Created by Ishu on 29/03/11.
//  Copyright 2011 Kiwitech. All rights reserved.
//



@interface DownloadFiles : NSObject 

@property(nonatomic,strong)id callBackTarget;
@property(nonatomic,assign)SEL callBackSelector;
@property(nonatomic, strong)NSString *fileDocPath;
@property(nonatomic, strong)NSString *filePath;
@property(nonatomic)BOOL isZip;
- (BOOL)checkNetworkStatus;
- (void)startDownload:(NSString *)fileURL withOffset:(int)offset;
-(void)cancelDownloading;
@end
